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

  (setq helm-buffer-max-length 30 ;; Length of the filename column
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)

  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x f") 'helm-find-files)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x s") 'helm-semantic-or-imenu)
  (global-set-key (kbd "C-x h") 'helm-find)
  )

(use-package helm-ag
  :config
  (global-set-key (kbd "C-x a") 'helm-do-grep-ag)
  (global-set-key (kbd "C-x C-a") 'helm-ag-project-root)
  )

(use-package helm-projectile)
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (define-key projectile-mode-map (kbd "C-c b") 'helm-projectile) ;; project buffers
  (define-key projectile-mode-map (kbd "C-c p p") 'helm-projectile-switch-project) ;; switch project
  ;;(setq projectile-switch-project-action 'helm-projectile-switch-project)
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-directories
        (append '(
                  ".git"
                  ".svn"
                  "Admin2"
                  )
                projectile-globally-ignored-directories))
  (setq projectile-globally-ignored-files
        (append '(
                  ".DS_Store"
                  ".classpath"
                  ".gitignore"
                  "*.gz"
                  "*.pyc"
                  "*.jar"
                  "*.tar.gz"
                  "*.tgz"
                  "*.zip"
                  )
                projectile-globally-ignored-files))
  )

(provide 'init-helm-projectile)
