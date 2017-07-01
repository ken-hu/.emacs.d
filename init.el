(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)

(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq create-lockfiles nil)
(setq backup-directory-alist `(("." . "~/.emacs.bk")))
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.bk" t)))

(blink-cursor-mode 0)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(menu-bar-mode -1)
(setq mouse-wheel-scroll-amount '(0.07))
(setq mouse-wheel-progressive-speed nil)
(mouse-wheel-mode -1)
(setq ring-bell-function 'ignore)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(set-default-font "menlo-14")
(add-to-list 'default-frame-alist '(font . "menlo-14"))
(set-face-attribute 'default t :font "menlo-14")
(setq-default line-spacing 0.3)

(setq-default indent-tabs-mode nil)
(setq c-default-style "linux"
      c-basic-style: "bsd"
      c-basic-offset 4)

(load-theme 'dracula t)
;;(load-theme 'solarized t)
;;(set-frame-parameter nil 'background-mode 'dark)
;;(set-terminal-parameter nil 'background-mode 'dark)
;;(setq solarized-colors '256)
;;(enable-theme 'solarized)

(global-hl-line-mode 1)
;;(set-face-background 'hl-line "#3e4446")
;;(set-face-foreground 'highlight nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(eval-when-compile (require 'use-package))

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

;; Doesn't work for startup for now
;;(use-package linum
;;  :config
;;  (global-linum-mode t)
;;  (setq linum-relative-current-symbol "")
;;  ;;(with-eval-after-load 'linum (linum-relative-mode))
;;)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-backends (delete 'company-semantic company-backends))
  (add-to-list 'company-backends 'company-c-headers)
  (define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin)
  (setq company-idle-delay 0)
)

;;(use-package powerline
;;  :ensure t)
;;
;;(use-package smart-mode-line-powerline-theme
;;  :ensure t)
;;
;;(use-package smart-mode-line
;;  :ensure t
;;  :config
;;  (require 'powerline)
;;  (setq powerline-default-separator 'arrow-fade)
;;  (setq sml/theme 'powerline)
;;  (sml/setup)
;;)

;;(setq mode-line-format
;;      (list
;;       ;; value of `mode-name'
;;       "%m: "
;;       ;; value of current buffer name
;;       "buffer %b, "
;;       ;; value of current line number
;;       "line %l "
;;       "-- user: "
;;       ;; value of user
;;       (getenv "USER")))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-x p") 'switch-to-previous-buffer)

(use-package company-rtags)

(use-package rtags
  :config
  (setq rtags-completions-enabled t)
  (setq rtags-use-helm t)
  (add-to-list 'exec-path (expand-file-name "/usr/local/bin"))
  (eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
  (setq rtags-autostart-diagnostics t)
  ;;(rtags-enable-standard-keybindings)
  (eval-after-load 'rtags
    (dolist (mode '(c-mode c++-mode))
      (evil-leader/set-key-for-mode mode
	"s" 'rtags-find-symbol-at-point
	"r" 'rtags-find-references-at-point
	"v" 'rtags-find-virtuals-at-point
	"V" 'rtags-print-enum-value-at-point
	"ar" 'rtags-find-all-references-at-point

	"fs" 'rtags-find-symbol
	"fr" 'rtags-find-references
	"ff" 'rtags-find-file

	"R" 'rtags-rename-symbol
	"I" 'rtags-symbol-info

	"[" 'rtags-location-stack-back
	"]" 'rtags-location-stack-forward
	"Y" 'rtags-cycle-overlays-on-screen
	"D" 'rtags-diagnostics
	"G" 'rtags-guess-function-at-point
	"p" 'rtags-set-current-project
	"P" 'rtags-print-dependencies
	"e" 'rtags-reparse-file
	"E" 'rtags-preprocess-file

	"S" 'rtags-display-summary
	"O" 'rtags-goto-offset
	"i" 'rtags-fixit
	"L" 'rtags-copy-and-print-current-location
	"X" 'rtags-fix-fixit-at-point
	"B" 'rtags-show-rtags-buffer
	"M" 'rtags-imenu
	"T" 'rtags-taglist
	"h" 'rtags-print-class-hierarchy
	"A" 'rtags-print-source-arguments)))
)

(use-package flycheck-rtags
  :config
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)
  (defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)
)

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
)

(use-package helm-projectile)

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (setq projectile-switch-project-action 'helm-projectile)
  (setq projectile-enable-caching t)
)
