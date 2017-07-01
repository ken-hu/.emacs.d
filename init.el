(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)

(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq backup-directory-alist `(("." . "~/.emacs.bk")))

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

(eval-when-compile (require 'use-package))

(use-package evil
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
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

(use-package company-rtags
)

(add-to-list 'exec-path (expand-file-name "/usr/local/bin"))
(use-package rtags
  :config
  (setq rtags-completions-enabled t)
  (eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
  (setq rtags-autostart-diagnostics t)
  ;;(rtags-enable-standard-keybindings)
  (eval-after-load 'rtags
    '(progn
       (mapc (lambda (x)
               (define-key c-mode-base-map
                 (kbd (concat "C-x r " (car x))) (cdr x)))
             '(("s" . rtags-find-symbol-at-point)
               ("," . rtags-find-references-at-point)
               ("v" . rtags-find-virtuals-at-point)
               ("V" . rtags-print-enum-value-at-point)
               ("/" . rtags-find-all-references-at-point)
               ("Y" . rtags-cycle-overlays-on-screen)
               (">" . rtags-find-symbol)
               ("<" . rtags-find-references)
               ("-" . rtags-location-stack-back)
               ("+" . rtags-location-stack-forward)
               ("D" . rtags-diagnostics)
               ("G" . rtags-guess-function-at-point)
               ("p" . rtags-set-current-project)
               ("P" . rtags-print-dependencies)
               ("e" . rtags-reparse-file)
               ("E" . rtags-preprocess-file)
               ("R" . rtags-rename-symbol)
               ("M" . rtags-symbol-info)
               ("S" . rtags-display-summary)
               ("O" . rtags-goto-offset)
               (";" . rtags-find-file)
               ("F" . rtags-fixit)
               ("X" . rtags-fix-fixit-at-point)
               ("B" . rtags-show-rtags-buffer)
               ("I" . rtags-imenu)
               ("T" . rtags-taglist)))))
)

(use-package rtags-helm
  :config
  (setq rtags-use-helm t)
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

(global-set-key (kbd "C-x g") 'magit-status)
