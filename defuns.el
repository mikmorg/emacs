;;----------------------------------------------------------------------------
;; Custom functions
;;----------------------------------------------------------------------------

(defun dot-emacs (relative-path)
  "Return the full path of a file in the user's emacs directory."
  (expand-file-name (concat user-emacs-directory relative-path)))

(defun my-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

;;----------------------------------------------------------------------------
;; Evil mode helpers
;;----------------------------------------------------------------------------

(defun my-evil-terminal-cursor-change ()
  (interactive)
  (when (string= (getenv "TERM_PROGRAM") "iTerm.app")
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\e]50;CursorShape=1\x7")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
  (when (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(add-hook 'after-make-frame-functions (lambda (frame) (my-evil-terminal-cursor-change)))
(my-evil-terminal-cursor-change)

;;To get the cursor to change in insert mode in iTerm
(defun my-evil-modeline-change (default-color)
  "changes the modeline color when the evil mode changes"
  (let ((color (cond ((evil-insert-state-p) '("#8700ff" . "#ffffff"))
                     ((evil-visual-state-p) '("#646c9c" . "#ffffff"))
                     ((evil-normal-state-p) default-color)
                     (t '("#440000" . "#ffffff")))))
    (set-face-background 'mode-line (car color))
    (set-face-foreground 'mode-line (cdr color))))

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

;;----------------------------------------------------------------------------
;; Helpers for moving text around
;;----------------------------------------------------------------------------

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun text-shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.
A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))

(defun text-shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (text-shift-right (* -1 (or arg 1))))

;;----------------------------------------------------------------------------
;; Buffer Utils
;;----------------------------------------------------------------------------

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun untabify-buffer ()
  "Replaces all tabs in the buffer with spaces."
  (interactive)
  (untabify (point-min) (point-max)))

(defun untabify-buffer-or-region ()
  "Replaces all tabs in the buffer with spaces."
  (interactive)
  (if mark-active
      (untabify-buffer)
    (untabify (point-min) (point-max))))

(defun nuke-all-buffers ()
  "Kill all buffers, leaving *scratch* only."
  (interactive)
  (mapcar (lambda (x) (kill-buffer x)) (buffer-list)) (delete-other-windows))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace))

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'cleanup-buffer)

(defun back-to-indentation-or-beginning-of-line ()
  "Moves point back to indentation if there is any
non blank characters to the left of the cursor.
Otherwise point moves to beginning of line."
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun insert-soft-tab ()
  " Tab with spaces"
  (interactive)
  (insert "   "))

(defun switch-to-other-buffer ()
  "Toggle previous buffers"
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun buffer-exists (bufname) (not (eq nil (get-buffer bufname))))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  ;; Don't switch back to the ibuffer!!!
  (if (buffer-exists "*Ibuffer*")  (kill-buffer "*Ibuffer*"))
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun matts-ibuffer ()
  "Open ibuffer with cursour pointed to most recent buffer name"
  (interactive)
  (let ((recent-buffer-name (buffer-name)))
    (ibuffer)
    (ibuffer-jump-to-buffer recent-buffer-name)))

(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg.  For use in hooks."
  (interactive)
  (flyspell-mode 1))

;;----------------------------------------------------------------------------
;; Window helpers
;;----------------------------------------------------------------------------

(defun my-close-current-window-asktosave ()
  "Kill the buffer, but not the window"
  (interactive)
  (kill-buffer (current-buffer)))

(defun matts-close-and-delete-window ()
  "Kill the current frame and the window and go back to the first window"
  (interactive)
  (matts-first-window)
  (other-window 1)
  (kill-buffer (current-buffer))
  (delete-window))

(defun matts-first-window ()
  (interactive)
  (select-window (frame-first-window)))

(defun matts-flip-windows ()
  ";; Swap windows if in split-screen mode"
  (interactive)
  (let ((cur-buffer (current-buffer))
        (top-buffer)
        (bottom-buffer))
    (pop-to-buffer (window-buffer (frame-first-window)))
    (setq top-buffer (current-buffer))
    (other-window 1)
    (setq bottom-buffer (current-buffer))
    (switch-to-buffer top-buffer)
    (other-window -1)
    (switch-to-buffer bottom-buffer)
    (pop-to-buffer cur-buffer)))

(defun switch-to-scratch ()
  "switch to scratch, grab the region if it's active"
  (interactive)
  (let ((contents
         (and (region-active-p)
              (buffer-substring (region-beginning)
                                (region-end)))))
    (switch-to-buffer "*scratch*")
    (if contents
        (progn
          (goto-char (buffer-end 1))
          (insert contents)))))

;;----------------------------------------------------------------------------
;; IDO related functions
;;----------------------------------------------------------------------------

(defun matts-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recent open: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

(defun choose-from-menu (menu-title menu-items)
  "Choose from a list of choices from a popup menu."
  (let ((item)
        (item-list))
    (while menu-items
      (setq item (car menu-items))
      (if (consp item)
          (setq item-list (cons (cons (car item) (cdr item) ) item-list))
        (setq item-list (cons (cons item item) item-list)))
      (setq menu-items (cdr menu-items)))
    (x-popup-menu
     `((500 200) ,(selected-frame))
     (list menu-title (cons menu-title (nreverse item-list))))))

;;----------------------------------------------------------------------------
;; File related helpers
;;----------------------------------------------------------------------------

(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))
(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun markdown-preview-file ()
  "This function will open Marked.app and monitor the current markdown document
for anything changes.  In other words, it will live reload and convert the
markdown documment"
  (interactive)
  (shell-command
   (format "open -a /Applications/Marked.app %s"
           (shell-quote-argument (buffer-file-name))))
  )

;;----------------------------------------------------------------------------
;; UI-related helpers
;;----------------------------------------------------------------------------

;; Highlights HTML/CSS color specifications
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{3,6\\}"
     (0 (let ((colour (match-string-no-properties 0)))
          (if (or (= (length colour) 4)
                  (= (length colour) 7))
              (put-text-property
               (match-beginning 0)
               (match-end 0)
               'face (list :background (match-string-no-properties 0)
                           :foreground (if (>= (apply '+ (x-color-values
                                                          (match-string-no-properties 0)))
                                               (* (apply '+ (x-color-values "white")) .6))
                                           "black" ;; light bg, dark text
                                         "white" ;; dark bg, light text
                                         )))))
        append))))

(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords t))

(require 'powerline)
(defun powerline-clean-theme ()
  "Customize the modeline with help from the powerline package"
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (lhs (list (powerline-raw (concat "L%l") nil 'l)))
                          (rhs (list
                                (if (buffer-modified-p)
                                    (powerline-raw "*" nil 'r))
                                (powerline-raw (concat "")  nil 'r)
                                (powerline-raw (concat "(%m) %p")  nil 'l)))
                          (center (list (powerline-raw "%b" nil) )))
                     (concat
                      (powerline-render lhs)
                      (powerline-fill-center nil (/ (powerline-width center) 2.0))
                      (powerline-render center)
                      (powerline-fill nil (powerline-width rhs))
                      (powerline-render rhs)))))))
(powerline-clean-theme)

(defun reload-color-theme ()
  "Reloads the color themes. Handy when experimenting with various colors"
  (interactive)
  (load-file "~/.emacs.d/color-theme-neptune.el")
  (color-theme-neptune))

(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region."
  (interactive "r")
  (save-excursion
    ;; split <foo><bar> or </foo><bar>, but not <foo></foo>
    (goto-char begin)
    (while (search-forward-regexp ">[ \t]*<[^/]" end t)
      (backward-char 2) (insert "\n") (incf end))
    ;; split <foo/></foo> and </foo></foo>
    (goto-char begin)
    (while (search-forward-regexp "<.*?/.*?>[ \t]*<" end t)
      (backward-char) (insert "\n") (incf end))
    ;; put xml namespace decls on newline
    (goto-char begin)
    (while (search-forward-regexp "\\(<\\([a-zA-Z][-:A-Za-z0-9]*\\)\\|['\"]\\) \\(xmlns[=:]\\)" end t)
      (goto-char (match-end 0))
      (backward-char 6) (insert "\n") (incf end))
    (indent-region begin end nil)))


;;----------------------------------------------------------------------------
;; Company mode related functions
;;----------------------------------------------------------------------------

(defun company-pseudo-tooltip-on-explicit-action (command)
  "`company-pseudo-tooltip-frontend', but only on an explicit action."
  (when (company-explicit-action-p)
    (setq tip-showing t)
    (company-pseudo-tooltip-frontend command)))

(defun company-echo-metadata-on-explicit-action-frontend (command)
  "`company-mode' front-end showing the documentation in the echo area."
  (pcase command
    (`post-command (when (company-explicit-action-p)
                     (company-echo-show-when-idle 'company-fetch-metadata)))
    (`hide
     (company-echo-hide)
     (setq tip-showing nil)
     )))


;;----------------------------------------------------------------------------
;; Ruby related functions
;;----------------------------------------------------------------------------

(defun my-sass-comment-fix ()
  "Change the default commenting sequence for sass"
  (set 'comment-start "//")
  )

;;----------------------------------------------------------------------------
;; Dired related functions
;;----------------------------------------------------------------------------

(defun matts-dired-open-mac ()
  "Remap 'o' in dired mode to open a file"
  (interactive)
  (let ((file-name (dired-get-file-for-visit)))
    (if (file-exists-p file-name)
        (call-process "/usr/bin/open" nil 0 nil file-name))))

(put 'dired-find-alternate-file 'disabled nil)
(defun matts-dired-up-directory ()
  "Go up one directory and don't create a new dired buffer but
reuse the current one."
  (interactive)
  (find-alternate-file ".."))

(defun dired-touch-now (touch-file)
  "Do `touch' command with TOUCH-FILE."
  (interactive "sNew file: ")
  (cd (dired-current-directory))
  (shell-command
   (concat "touch \""
           ;; if filename is begin with `-', add '-- ' before file-name
           (if (string-match "^-.*" touch-file) "-- ")
           touch-file "\""))
  (sit-for 0.1)
  (revert-buffer)
  (dired-goto-file (concat (dired-current-directory) touch-file)))

;;----------------------------------------------------------------------------
;; Project Roots
;;----------------------------------------------------------------------------

(defvar *project-roots*
  '(".git" ".hg" "Rakefile" "Makefile" "README" "build.xml" ".emacs-project" "Gemfile")
  "The presence of any file/directory in this list indicates a project root.")
(defvar *project-root* nil
  "Used internally to cache the project root.")

(defun root-match(root names)
  (member (car names) (directory-files root)))

(defun root-matches(root names)
  (if (root-match root names)
      (root-match root names)
    (if (eq (length (cdr names)) 0)
        'nil
      (root-matches root (cdr names))
      )))

(defun project-root ()
  "Returns the current project root."
  (when (or
         (null *project-root*)
         (not (string-match *project-root* default-directory)))
    (let ((root (find-project-root)))
      (if root
          (setq *project-root* (expand-file-name (concat root "/")))
        (setq *project-root* nil))))
  *project-root*)

(defun find-project-root (&optional root)
  "Determines the current project root by recursively searching for an indicator."
  (when (null root) (setq root default-directory))
  (cond
   ((root-matches root *project-roots*)
    (expand-file-name root))
   ((equal (expand-file-name root) "/") nil)
   (t (find-project-root (concat (file-name-as-directory root) "..")))))

(provide 'defuns)
