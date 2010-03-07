;;----------------------------------------------------------------------------
;; Snippets
;;----------------------------------------------------------------------------

(vendor 'yasnippet)
(require 'yasnippet)
(yas/initialize)

;; Load my custom snippets
(yas/load-directory "~/.emacs.d/mattsears/snippets")
(yas/load-directory "~/.emacs.d/vendor/yasnippets-shoulda")
(yas/load-directory "~/.emacs.d/vendor/cucumber/snippets/feature-mode")
;(make-variable-buffer-local 'yas/trigger-key)
(setq yas/global-mode t)