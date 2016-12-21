;; 42 C style
(setq-default c-default-style "linux"
			  c-basic-offset 4
			  c-block-comment-prefix "**"
			  tab-width 4
			  indent-tabs-mode t)

(defun close-comm ()
  (setq-default comment-multi-line t)
  (define-key evil-insert-state-map (kbd "RET") 'c-context-line-break)
  (add-to-list 'c-cleanup-list 'comment-close-slash))

(add-hook 'c-mode-hook 'close-comm)
