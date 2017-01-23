;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
	 asm
	 (auto-completion :enabled-for c-c++ ocaml
					  :variables auto-completion-return-key-behavior nil
					  auto-completion-tab-key-behavior 'complete
					  auto-completion-enable-snippets-in-popup t)
	 born2code
	 (c-c++ :packages (not xcscope)
			:variables c-c++-enable-clang-support t)
	 dash
	 emacs-lisp
	 (git :variables git-magit-status-fullscreen t)
	 gtags
	 helm
	 markdown
	 ocaml
	 org
	 osx
	 python
	 (semantic :enabled-for c-c++)
	 (shell :variables shell-default-shell 'ansi-term)
	 (syntax-checking :variables syntax-checking-enable-tooltips t)
	 (version-control :packages diff-mode diff-hl evil-unimpaired
					  :variables version-control-diff-tool 'diff-hl
					  version-control-global-margin t)
	 )
   dotspacemacs-additional-packages '(
									  all-the-icons)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(
									request
									google-translate)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   dotspacemacs-elpa-https nil
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
								(projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(
						 atom-one-dark
						 gruvbox
						 zerodark
						 )
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Office Code Pro"
							   :size 13
							   :weight light
							   :width normal
							   :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'right-then-bottom
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup t
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers 'relative
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  ;; fonts
  (defadvice set-face-attribute
	  (before no-bold (face frame &rest args) activate)
	(setq args
		  (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
				  args)))
  (setq-default
   ;; evil
   evil-shift-round nil
   ;; smartparens
   sp-highlight-pair-overlay nil
   sp-highlight-wrap-overlay nil
   sp-highlight-wrap-tag-overlay nil
   ;; flycheck
   flycheck-check-syntax-automatically '(save mode-enabled)
   ;; whitespace
   whitespace-style '(face tabs tab-mark newline-mark)
   whitespace-display-mappings
   '((newline-mark 10 [172 10])
	 (tab-mark 9 [9655 9]))
   )
  )

(defun dotspacemacs/user-config ()
  ;; custom bindings
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
  (spacemacs/set-leader-keys "oa" 'org-annotate-file)
  ;; hooks
  (add-hook 'makefile-mode-hook 'whitespace-mode)
  ;; highlight
  (spacemacs/toggle-highlight-current-line-globally-off)
  ;;variables
  ;;org
  (setq-default org-annotate-file-add-search t)
  ;;dumb-jump
  (setq dumb-jump-selector 'helm)
  ;;looks
  (setq-default line-spacing 0.1)
  (setq powerline-default-separator 'alternate)
  ;; highlight C functions
  (font-lock-add-keywords
   'c-mode
   '(("\\<\\(\\sw+\\) ?(" 1 'font-lock-function-name-face))
   t)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
