(use-package evil-leader
  :config
  (global-evil-leader-mode t)
)

(use-package evil
  :config
  (evil-mode t)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-leader/set-leader ",")
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  ;; Ignore EOF in visual mode
  (define-key evil-visual-state-map (kbd "h") 'backward-char)
  (define-key evil-visual-state-map (kbd "l") 'forward-char)
  ;; Disable mouse scrollling in insert mode
  (add-hook 'evil-insert-state-entry-hook (lambda() (mouse-wheel-mode -1)))
  (add-hook 'evil-insert-state-exit-hook 'mouse-wheel-mode -1)
  (add-hook 'evil-insert-state-exit-hook 'my-save-if-bufferfilename)
  ;; Treat underscore as a part of the word
  (add-hook 'evil-normal-state-entry-hook (lambda() (modify-syntax-entry ?_  "w")))
)

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

;; :[w]q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "[w]q" 'kill-this-buffer)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)

(provide 'init-evil)
