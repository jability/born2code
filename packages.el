;;; packages.el --- born2code layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: jlinden <jlinden@kb-firmware>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `born2code-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `born2code/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `born2code/pre-init-PACKAGE' and/or
;;   `born2code/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

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
  (spacemacs|use-package-add-hook flycheck
    :config
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

;; (defun born2code/post-init-flycheck ()
;;   (use-package flycheck
;;     :config
;;       (flycheck-define-checker norminette
;;         "Norminette checker"
;;         :command ("norminette" source)
;;         :error-patterns
;;         ((info line-start "Norme: " (file-name) line-end)
;;          (warning line-start "Error (line " line "): " (message) line-end)
;;          (warning line-start "Error (line " line ", col " column "): " (message) line-end) 
;;          (warning line-start "Error: " (message) line-end))
;;         :modes (c-mode))
;;       (add-to-list 'flycheck-checkers 'norminette)
;; 	  ))

;;; packages.el ends here
