(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq create-lockfiles nil)
;;(setq backup-directory-alist `(("." . "~/.emacs.bk/")))
;;(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.bk/" t)))
;;(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
;;(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Disable backup and autosave
(setq make-backup-files nil)
(setq auto-save-default nil)

(blink-cursor-mode 0)
(global-auto-revert-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(menu-bar-mode -1)
(setq mouse-wheel-scroll-amount '(0.07))
(setq mouse-wheel-progressive-speed nil)
(mouse-wheel-mode 1)
(setq ring-bell-function 'ignore)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(set-default-font "menlo-14")
(add-to-list 'default-frame-alist '(font . "menlo-14"))
(set-face-attribute 'default t :font "menlo-14")
(setq-default line-spacing 0.2)

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

(global-hl-line-mode 1) ;; cursor line
;;(set-face-background 'hl-line "#3e4446")
;;(set-face-foreground 'highlight nil)

(setq echo-keystrokes 0.1 ;; Show the command in minibuffer immediately
      use-dialog-box nil  ;; Disable any pop up
      visible-bell t)
(show-paren-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

(global-visual-line-mode t) ;; No words wrapping arrows

;; Set the frame title format to "buffer-name (full-path)"
;; Mark that there are unsaved changes
(setq frame-title-format
      '("%b "
        (:eval (if (buffer-file-name)
                   (progn
                     (setq name (abbreviate-file-name (buffer-file-name)))
                     `("(",name")"))
                 ))
        (:eval (if (buffer-modified-p)
                   " •"))
        ))

;; turn on which func mode by default
(which-func-mode 1)

;; dashboard
(use-package all-the-icons
  :config
  :hook all-the-icons-install-fonts)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)
                          (agenda . 5)
                          ;;(registers . 5)
                          ))
  (setq dashboard-banner-logo-title "Life Is Good")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-page-separator "\n\n")
)

;; resize windows
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)

(provide 'init-custom)
