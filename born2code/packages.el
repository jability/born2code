(defconst born2code-packages
  '(
	flycheck
	(helm-cscope :toggle (configuration-layer/package-usedp 'helm))
	xcscope
	(header :location local)
  ))

(defun born2code/init-header ()
  (use-package header
	:load-path "private/born2code/local/libs/"
	:init
	(spacemacs/set-leader-keys "oh" 'header42-insert)))

(defun born2code/post-init-flycheck ()
  (with-eval-after-load "flycheck"
      (flycheck-define-checker norminette
        "Norminette checker"
        :command ("norminette" source)
        :error-patterns
        ((info line-start "Norme: " (file-name) line-end)
         (warning line-start "Error (line " line "): " (message) line-end)
         (warning line-start "Error (line " line ", col " column "): " (message) line-end) 
         (warning line-start "Error: " (message) line-end))
        :modes (c-mode))
      (add-to-list 'flycheck-checkers 'norminette t)
	  (flycheck-add-next-checker 'c/c++-clang 'norminette)
	  ))

(defun born2code/init-xcscope ()
  (use-package xcscope
    :commands (cscope-index-files cscope/run-pycscope)
    :init
    (progn
      ;; for python projects, we don't want xcscope to rebuild the databse,
      ;; because it uses cscope instead of pycscope
      (setq cscope-option-do-not-update-database t
            cscope-display-cscope-buffer nil)

	  (spacemacs/declare-prefix "mc" "c-scope")
	  (dolist (mode '(c-mode c++-mode))
		(spacemacs/set-leader-keys-for-major-mode mode "ci" 'cscope-index-files))
      (defun cscope//safe-project-root ()
        "Return project's root, or nil if not in a project."
        (and (fboundp 'projectile-project-root)
             (projectile-project-p)
             (projectile-project-root)))

      (defun cscope/run-pycscope (directory)
        (interactive (list (file-name-as-directory
                            (read-directory-name "Run pycscope in directory: "
                                                 (cscope//safe-project-root)))))
        (let ((default-directory directory))
          (shell-command
           (format "pycscope -R -f '%s'"
                   (expand-file-name "cscope.out" directory))))))))

(defun born2code/init-helm-cscope ()
  (use-package helm-cscope
    :defer t
    :init
    (defun spacemacs/setup-helm-cscope (mode)
      "Setup `helm-cscope' for MODE"
      (spacemacs/set-leader-keys-for-major-mode mode
        "cc" 'helm-cscope-find-called-function
        "cC" 'helm-cscope-find-calling-this-funtcion
        "cd" 'helm-cscope-find-global-definition
        "ce" 'helm-cscope-find-egrep-pattern
        "cf" 'helm-cscope-find-this-file
        "cF" 'helm-cscope-find-files-including-file
        "cr" 'helm-cscope-find-this-symbol
        "cx" 'helm-cscope-find-this-text-string))
    :config
    (defadvice helm-cscope-find-this-symbol (before cscope/goto activate)
(evil--jumps-push))))
