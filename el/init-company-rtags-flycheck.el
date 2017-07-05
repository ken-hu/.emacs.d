(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-backends (delete 'company-semantic company-backends))
  (add-to-list 'company-backends 'company-c-headers)
  (define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin)
  (setq company-idle-delay 0)
)

(use-package rtags
  :config
  (require 'company-rtags)
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
        "fs" 'rtags-find-symbo
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

(provide 'init-company-rtags-flycheck)