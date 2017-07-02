(use-package helm
  :config
  (helm-mode t)
  (helm-autoresize-mode t)

  (semantic-mode t)
  (setq helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match    t)


  (setq helm-display-header-line nil)
  (eval-after-load 'helm
    (lambda ()
      (set-face-attribute 'helm-source-header nil
                          ;;:foreground "white"
                          ;;:background ""
                          :height 200)))

  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)

  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x f") 'helm-find-files)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x s") 'helm-semantic-or-imenu)
  (global-set-key (kbd "C-x h") 'helm-find)
)

(use-package projectile
  :config
  (require 'helm-projectile)
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (setq projectile-switch-project-action 'helm-projectile)
  (setq projectile-enable-caching t)
)

(provide 'init-helm-projectile)
