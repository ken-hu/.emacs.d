(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(add-to-list 'load-path "~/.emacs.d/el/")
(require 'init-custom)
(require 'init-powerline)
(require 'init-evil)
(require 'init-helm-projectile)
(require 'init-company-rtags-flycheck)
(require 'init-global-functions)
(require 'init-org)

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq magit-diff-highlight-hunk-body nil)
)
