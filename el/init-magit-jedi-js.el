(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x b") 'magit-blame-addition)
  (setq magit-diff-highlight-hunk-body nil)
)

(use-package markdown-mode
  :config
  (setq markdown-command "/usr/local/bin/markdown")
)

(use-package jedi
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
)

(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))
(add-hook 'js-mode-hook 'js-custom)

(provide 'init-magit-jedi-js)
