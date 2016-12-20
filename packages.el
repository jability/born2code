(defconst born2code-packages
  '(
	flycheck
	(list :location local)
	(string :location local)
	(comments :location local)
	(header :location local)
  ))

(defun born2code/init-list ()
  (use-package list
	:defer t))

(defun born2code/init-string ()
  (use-package string
	:defer t))

(defun born2code/init-comments ()
  (use-package comments
	:defer t))

(defun born2code/init-header ()
  (use-package header
	:commands (header42-insert)
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
      (add-to-list 'flycheck-checkers 'norminette)
	  ))
