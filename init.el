(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(setq ad-redefinition-action 'accept) ;; slient the warning
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package exec-path-from-shell
  :defer
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
)

(add-to-list 'load-path "~/.emacs.d/el/")
(require 'init-global-functions)
(require 'init-custom)
(require 'init-powerline)
(require 'init-helm-projectile)
(require 'init-evil)
(require 'init-company-rtags-flycheck-flyspell-yas)
(require 'init-magit-jedi-js)
(require 'init-org)
(require 'nuodb)
