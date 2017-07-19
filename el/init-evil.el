(use-package evil-leader
  :config
  (global-evil-leader-mode t)
)

(use-package evil
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  (evil-leader/set-leader ",")
  ;; Disable mouse scrollling in insert mode
  (add-hook 'evil-insert-state-entry-hook (lambda() (mouse-wheel-mode -1)))
  (add-hook 'evil-insert-state-exit-hook 'mouse-wheel-mode -1)
)

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

(provide 'init-evil)
