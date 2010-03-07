;; Finks Theme for Emacs.
;;
;; Defines a colour scheme resembling that of the original Textmate Blackboard theme.
;; To use add the following to your .emacs file (requires the color-theme package):
;;
;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "~/.emacs.d/color-theme/color-theme-neptune.el")
;;
;; And then (color-theme-neptune) to activate it.
;;
;; Several areas still require improvement such as recognition of code that ruby-mode doesn't
;; yet pick up (eg. parent classes), Rails/Merb keywords, or non Ruby code related areas
;; (eg. dired, HTML, etc). Please feel free to customize further and send in any improvements,
;; patches most welcome.
;;
;; MIT License Copyright (c) 2008 Matt Sears <matt@mattsears.com>
;; Credits due to the excellent TextMate Blackboard theme
;;
(defun color-theme-neptune()
  "Emacs color theme by Matt Sears, based off the TextMate Blackboard theme, created 2008-08-18"
  (interactive)
  (color-theme-install
   '(color-theme-neptune
     ((background-color . "#121212")
      (background-mode . dark)
      (border-color . "#dedede")
      (cursor-color . "#AFAFAF")
      (foreground-color . "#F8F8F8")
      (mouse-color . "sienna1"))
     ((help-highlight-face . underline)
     (list-matching-lines-face . bold)
      (sgml-set-face . "#7587A6")
      (tags-tag-face . "#7587A6"))
     (neptune-black ((t (:foreground "#121212"))))
     (neptune-white ((t (:foreground "#F8F8F8"))))
     (neptune-blue ((t (:foreground "#75879e"))))
     (neptune-light-blue ((t (:foreground "#8dc1de"))))
     (neptune-orange ((t (:foreground "#CF6A4C"))))
     (neptune-brown ((t (:foreground "#CDA869"))))
     (neptune-purple ((t (:foreground "#aa97ab"))))
     (neptune-turquoise ((t (:foreground "#87c4bf")))) ;
     (neptune-green ((t (:foreground "#9fab7d"))))
     (neptune-light-green ((t (:foreground "#e3f3b2"))))
     (neptune-red ((t (:foreground "#CF6A4C"))))
     (neptune-grey ((t (:foreground "#726d73"))))
     (neptune-gold ((t (:foreground "#cdc098"))))
     (neptune-yellow ((t (:foreground "#dad085"))))
     (neptune-bg ((t (:background "#0C1021"))))
     (neptune-highlight ((t (:background "#3b4043"))))
     (neptune-current-line ((t (:background "#1a1d2f"))))

     (text-face ((t (:foreground neptune-orange))))

     (bold ((t (:bold t))))
     (bold-italic ((t (:bold t))))
     (border-glyph ((t (nil))))
     (border ((t (:inherit neptune-bg))))
     (buffers-tab ((t (:inherit neptune-blue))))

     (font-lock-builtin-face ((t (:inherit neptune-light-blue))))
     (font-lock-comment-face ((t (:italic t :inherit neptune-grey))))
     (font-lock-comment-delimiter-face ((t (:inherit neptune-grey))))
     (font-lock-constant-face ((t (:inherit neptune-red))))
     (font-lock-doc-string-face ((t (:inherit neptune-green))))
     (font-lock-doc-face ((t (:inherit neptune-light-green))))
     (font-lock-function-name-face ((t (:inherit neptune-gold))))
     (font-lock-keyword-face ((t (:inherit neptune-brown))))
     (font-lock-preprocessor-face ((t (:inherit neptune-blue))))

     (font-lock-reference-face ((t (:inherit neptune-blue))))
     (font-lock-regexp-grouping-backslash ((t (:inherit neptune-light-blue))))
     (font-lock-regexp-grouping-construct ((t (:inherit neptune-red))))
     (font-lock-string-face ((t (:inherit neptune-green))))
     (font-lock-type-face ((t (:inherit neptune-purple))))
     (font-lock-variable-name-face ((t (:inherit neptune-blue))))
     (font-lock-warning-face ((t (:inherit neptune-red))))
     (font-lock-negation-char-face ((t (nil))))
     (header-line ((t (:bold t :weight bold :underline t :foreground "grey20" :box nil))))

     (dired-face-directory ((t (:inherit neptune-blue))))
     (dired-face-executable ((t (:inherit neptune-green))))
     (dired-face-flagged ((t (:inherit neptune-orange))))
     (dired-face-marked ((t (:inherit neptune-orange))))
     (dired-face-permissions ((t (:inherit neptune-blue))))
     (dired-face-boring ((t (:inherit neptune-grey))))
     (dired-face-header ((t (:inherit neptune-blue))))
     (dired-face-setuid ((t (:inherit neptune-red))))
     (dired-face-socket ((t (:inherit neptune-red))))
     (dired-face-symlink ((t (:inherit neptune-green))))

	 ;; The Shell
     (eshell-prompt-face ((t (:inherit neptune-green))))
     (eshell-prompt ((t (:inherit neptune-green))))
     (eshell-ls-archive-face ((t (:inherit neptune-blue))))
     (eshell-ls-archive ((t (:inherit neptune-blue))))
     (eshell-ls-backup-face ((t (:inherit neptune-light-blue))))
     (eshell-ls-backup ((t (:inherit neptune-light-blue))))
     (eshell-ls-clutter-face ((t (:inherit neptune-white))))
     (eshell-ls-clutter ((t (:inherit neptune-white))))
     (eshell-ls-directory-face ((t (:inherit neptune-blue))))
     (eshell-ls-directory ((t (:inherit neptune-blue))))
     (eshell-ls-executable-face ((t (:inherit neptune-white))))
     (eshell-ls-executable ((t (:inherit neptune-white))))
     (eshell-ls-missing-face ((t (:inherit neptune-green))))
     (eshell-ls-missing ((t (:inherit neptune-white))))
     (eshell-ls-product-face ((t (:inherit neptune-green))))
     (eshell-ls-product ((t (:inherit neptune-green))))
     (eshell-ls-readonly-face ((t (:inherit neptune-red))))
     (eshell-ls-readonly ((t (:inherit neptune-red))))
     (eshell-ls-special-face ((t (:inherit neptune-orange))))
     (eshell-ls-special ((t (:inherit neptune-orange))))
     (eshell-ls-symlink-face ((t (:inherit neptune-blue))))
     (eshell-ls-symlink ((t (:inherit neptune-blue))))
     (eshell-ls-unreadable-face ((t (:inherit neptune-red))))
     (eshell-ls-unreadable ((t (:inherit neptune-red))))
	
	 ;; Spelling mistakes
     (flyspell-duplicate-face ((t (:underline t))))
     (flyspell-incorrect-face ((t (:underline "#b9402a"))))
     (fringe ((t (:inherit neptune-bg))))

     (isearch ((t (:inherit neptune-highlight))))
     (isearch-lazy-highlight-face ((t (:inherit neptune-highlight))))
     (isearch-secondary ((t (:inherit neptune-highlight))))
     (isearch-fail ((t (:inherit neptune-red))))

     ;; ibuffer
     (ibuffer-deletion-face ((t (:inherit neptune-red))))
     (ibuffer-filter-group-name-face ((t (:inherit neptune-blue))))
     (ibuffer-marked-face ((t (:inherit neptune-grey))))
     (ibuffer-title-face ((t (:inherit neptune-green))))
     (ibuffer-dired-buffer-face ((t (:inherit neptune-blue))))
     (ibuffer-help-buffer-face ((t (:inherit neptune-blue))))
     (ibuffer-hidden-buffer-face ((t (:inherit neptune-red))))
     (ibuffer-occur-match-face ((t (:inherit neptune-red))))
     (ibuffer-read-only-buffer-face ((t (:inherit neptune-red))))
     (ibuffer-special-buffer-face ((t (:inherit neptune-red))))
     (ibuffer-title-face ((t (:inherit neptune-blue))))

     ;; ido
     (ido-first-match ((t (:inherit neptune-green))))
     (ido-first-match-face ((t (:inherit neptune-orange))))
     (ido-incomplete-regexp ((t (:box (:line-width 1 :color "red4") :foreground "red2"))))
     (ido-indicator ((t (:inherit neptune-orange))))
     (ido-indicator-face ((t (:inherit neptune-red))))
     (ido-only-match ((t (:inherit neptune-green))))
     (ido-only-match-face ((t (:inherit neptune-green))))
     (ido-subdir ((t (:inherit neptune-orange))))
     (ido-subdir-face ((t (:inherit neptune-blue))))

     ;; nxml
     (nxml-name-face ((t (:inherit neptune-blue))))
     (nxml-comment-content-face ((t (:inherit neptune-grey))))
     (nxml-markup-declaration-delimiter-face ((t (:inherit neptune-grey))))
     (nxml-name ((t (:inherit neptune-blue))))
     (nxml-ref ((t (:inherit neptune-blue))))
     (nxml-ref-face ((t (:inherit neptune-blue))))
     (nxml-delimiter ((t (:inherit neptune-blue))))
     (nxml-delimiter-face ((t (:inherit neptune-blue))))
     (nxml-text ((t (:inherit neptune-blue))))
     (nxml-text-face ((t (nil))))
     (nxml-delimited-data ((t (:inherit font-lock-string))))
     (nxml-delimited-data-face ((t (:inherit neptune-blue))))
     (nxml-tag-delimiter-face ((t (:inherit neptune-blue))))
     (nxml-attribute-value ((t (:inherit neptune-green))))
     (nxml-attribute-value-face ((t (:inherit neptune-green))))
     (nxml-attribute-value-delimiter ((t (:inherit neptune-green))))
     (nxml-attribute-prefix ((t (:inherit neptune-blue))))
     (nxml-attribute-prefix-face ((t (:inherit neptune-green))))
     (nxml-attribute-local-name ((t (:inherit neptune-green))))
     (nxml-comment-content ((t (:inherit neptune-grey))))
     (nxml-comment-delimiter ((t (:inherit neptune-grey))))
     (nxml-comment-delimiter-face ((t (:inherit neptune-grey))))
     (nxml-processing-instruction-target ((t (:inherit neptune-blue))))
     (nxml-processing-instruction-delimiter ((t (:inherit nxml-processing-instruction-target))))
     (nxml-processing-instruction-content ((t (:inherit nxml-processing-instruction-target))))
     (nxml-cdata-section-CDATA ((t (:inherit neptune-grey))))
     (nxml-cdata-section-delimiter ((t (:inherit nxml-cdata-section-CDATA))))
     (nxml-cdata-section-content ((t (:inherit nxml-text))))
     (nxml-entity-ref-name((t (:inherit neptune-blue))))
     (nxml-entity-ref-delimiter ((t (:inherit nxml-entity-ref-name))))
     (nxml-char-ref-number ((t (:inherit nxml-entity-ref-name))))
     (nxml-char-ref-delimiter ((t (:inherit nxml-entity-ref-delimiter))))
     (nxml-tag-delimiter ((t (:inherit neptune-blue))))
     (nxml-tag-slash ((t (:inherit neptune-blue))))
     (nxml-element-local-name ((t (:inherit neptune-blue))))
     (nxml-element-prefix ((t (:inherit neptune-blue))))
     (nxml-element-colon ((t (:inherit neptune-blue))))
     (nxml-namespace-attribute-prefix ((t (:inherit neptune-blue))))
     (nxml-namespace-attribute-xmlns ((t (:inherit nxml-attribute-prefix))))
     (nxml-attribute-colon ((t (:inherit neptune-blue))))
     (nxml-namespace-attribute-colon ((t (:inherit nxml-attribute-colon))))
     (nxml-hash-face ((t (:inherit neptune-orange))))

     (mmm-code-submode-face ((t (:inherit neptune-white ))))
     (mmm-comment-submode-face ((t (:inherit neptune-grey))))
     (mmm-default-submode-face ((t (nil))))
     (mmm-output-submode-face ((t (:inherit neptune-white ))))
     (mmm-declaration-submode-face ((t (:inherit neptune-orange))))

     ;; ERB (Ruby Embedded in HTML)
     (erb-face ((t (:inherit neptune-white))))
     (erb-delim-face ((t (:inherit neptune-white))))
     (erb-out-face ((t (:inherit neptune-white))))
     (erb-out-delim-face ((t (:inherit neptune-white))))
     (erb-comment-delim-face ((t (:inherit neptune-grey))))
     (erb-comment-face ((t (:italic t :inherit neptune-grey))))

     ;; Do not highlight snippets
     (yas/field-highlight-face ((t (nil))))

     ;; org mode
     (org-level-1 ((t (:inherit neptune-blue))))
     (org-level-2 ((t (:inherit neptune-light-blue))))
     (org-level-3 ((t (:inherit neptune-green))))
     (org-level-4 ((t (:inherit neptune-blue))))
     (org-special-keyword ((t (:inherit neptune-blue))))
     (org-property-value ((t (:inherit neptune-green))))
     (org-link ((t (:inherit neptune-green :underline t))))
     (org-target ((t (:inherit neptune-white))))
     (org-date ((t (:inherit neptune-red))))
     (org-sexp-date ((t (:inherit neptune-red))))
     (org-tag ((t (:inherit neptune-green))))
     (org-todo ((t (:inherit neptune-green))))
     (org-done ((t (:inherit neptune-light-blue))))
     (org-headline-done ((t (:inherit neptune-green))))

     ;; ERC
     (erc-default-face ((t (:inherit neptune-blue))))
     (erc-fool-face ((t (:inherit neptune-red))))
     (erc-input-face ((t (:inherit neptune-white))))
     (erc-keyword-face ((t (:inherit neptune-light-blue))))
     (erc-timestamp-face ((t (:inherit neptune-light-blue))))
     (erc-notice-face ((t (:inherit neptune-green))))
     (erc-prompt-face ((t (:inherit neptune-white))))

     ;; Anything.el
     (anything-header ((t (:inherit neptune-blue))))
     (anything-isearch-match ((t (:inherit neptune-red))))

 	 ;; Full Ack
     (ack-match ((t (:inherit neptune-yellow))))
     (ack-file ((t (:inherit neptune-green))))
     (ack-line ((t (:inherit neptune-blue))))

	 ;; Fixme
	 (font-lock-fixme-face ((t (:foreground "#ffffff" :background "#75879e"))))

     (modeline ((t (:background "#373c4e" :foreground "#d2e0f6"))))
     (mode-line-inactive ((t (:foreground "#d2e0f6" :background "#373c4e"))))
     (modeline-buffer-id ((t (:bold nil))))

     (lazy-highlight-face ((t (:inherit neptune-current-line))))
     (hl-line ((t (:inherit neptune-current-line))))
     (highlight ((t (:inherit neptune-current-line))))
     (highline-face ((t (:inherit neptune))))
     (minibuffer-prompt ((t (:inherit neptune-blue))))

     (region ((t (:inherit neptune-highlight))))

     (show-paren-match-face ((t (nil))))
     (show-paren-match-face ((t (:inherit neptune-light-blue))))
     (show-paren-mismatch-face ((t (:inherit neptune-red))))

     (italic ((t (nil))))
     (left-margin ((t (nil))))
     (underline ((nil (:underline nil))))
     (vertical-border ((t (nil))))
     (semantic-dirty-token-face ((t (:inherit neptune-bg))))
     (semantic-unmatched-syntax-face ((t (nil))))
     (zmacs-region ((t (:inherit neptune-blue)))))))