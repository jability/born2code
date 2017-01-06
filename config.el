;; 42 C style
(setq-default c-default-style "linux"
			  c-backspace-function 'backward-delete-char
			  c-basic-offset 4
			  c-block-comment-prefix "**"
			  comment-multi-line t
			  tab-width 4
			  indent-tabs-mode t)

(defun close-comm ()
  (define-key evil-insert-state-map (kbd "RET") 'c-context-line-break)
  (add-to-list 'c-cleanup-list 'comment-close-slash))

(add-hook 'c-mode-hook 'close-comm)
