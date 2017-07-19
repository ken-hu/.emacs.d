(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq create-lockfiles nil)
(setq backup-directory-alist `(("." . "~/.emacs.bk/")))
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.bk/" t)))

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

(provide 'init-custom)
