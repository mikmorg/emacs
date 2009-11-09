;;----------------------------------------------------------------------------
;; Css mode
;;----------------------------------------------------------------------------
(require 'css-mode)
(autoload 'css-mode "css-mode" "Mode for editing CSS file" t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function 'cssm-c-style-indenter)

(defadvice cssm-complete-property
  (after cssm-complete-add-space activate)
  "Modify CSS completion to add a space after full completion."
  (when (eq (char-before) ?:) (insert " ")))

(define-skeleton cssm-insert-semicolon
  "Inserts a semicolon." nil
  ";" "\n" >)

(defadvice cssm-enter-mirror-mode
  (after cssm-enter-mirror-semicolon activate)
  "Add electric semicolons to css-mode's \"mirror mode.\""
  (define-key cssm-mode-map (read-kbd-macro ";")  'cssm-insert-semicolon))

(defadvice cssm-leave-mirror-mode
  (after cssm-leave-mirror-semicolon activate)
  "Add electric semicolons to css-mode's \"mirror mode.\""
  (define-key cssm-mode-map (read-kbd-macro ";")  'self-insert-command))

(add-hook 'css-mode-hook
	  '(lambda ()
	     (setq tab-width 2)
		 ;;(define-key css-mode-map [return] 'newline-and-indent)
		 (setq css-electric-brace-behavior t)
		 (setq css-electric-semi-behavior t)
	     (setq css-indent-offset 2)))
