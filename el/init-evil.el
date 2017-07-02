(use-package evil-leader
  :config
  (global-evil-leader-mode t)
)

(use-package evil
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  (evil-leader/set-leader ",")
)

(provide 'init-evil)