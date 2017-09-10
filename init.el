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

(use-package exec-path-from-shell
  :defer
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
)

(add-to-list 'load-path "~/.emacs.d/el/")
(require 'init-custom)
(require 'init-powerline)
(require 'init-evil)
(require 'init-company-rtags-flycheck)
(require 'init-helm-projectile)
(require 'init-global-functions)
(require 'init-org)
(require 'nuodb)

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq magit-diff-highlight-hunk-body nil)
)

(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'c++-mode-hook 'yas-minor-mode)
  (add-hook 'c-mode-hook 'yas-minor-mode)
  (add-hook 'python-mode-hook 'yas-minor-mode)
  (add-hook 'java-mode-hook 'yas-minor-mode)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (setq tab-always-indent 'complete)
  (setq yas-prompt-functions '(yas-completing-prompt
                               yas-ido-prompt
                               yas-dropdown-prompt))
  (define-key yas-minor-mode-map (kbd "<escape>") 'yas-exit-snippet)
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
