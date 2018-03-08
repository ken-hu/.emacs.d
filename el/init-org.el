(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; So org-capture works
(setq org-default-notes-file "~/Dropbox/org/capture.org")
(setq org-directory "~/Dropbox/org")
;; Open a file
(global-set-key (kbd "C-c o l") (lambda() (interactive) (find-file "~/Dropbox/org/log.org")))
(global-set-key (kbd "C-c o n") (lambda() (interactive) (find-file "~/Dropbox/org/note.org")))
;; C-c i to add to-do item -[ ]

;; (global-set-key (kbd "C-c o c") (lambda() (interactive) (find-file "~/Dropbox/org/checkbox.org")))
;; Code block highlight in orgmode
(setq org-src-fontify-natively t)
;; #+STARTUP: showeverything
(setq org-startup-folded nil)
(setq org-hide-emphasis-markers t) ;; Hide markup makers

;; Hide blocks by default
(add-hook 'org-mode-hook 'org-hide-block-all)
(add-hook 'org-mode-hook 'org-indent-mode) ;; org auto indentation
(defvar org-blocks-hidden nil)
(defun org-toggle-blocks ()
  (interactive)
  (if org-blocks-hidden
      (org-show-block-all)
    (org-hide-block-all))
  (setq-local org-blocks-hidden (not org-blocks-hidden)))
(add-hook 'org-mode-hook 'org-toggle-blocks)

(add-hook 'org-mode-hook
          (lambda()
            (local-set-key (kbd "C-c :") nil) ;; disable org-toggle-fixed-width-section
            (local-set-key (kbd "C-c e") 'outline-show-all)
            (local-set-key (kbd "C-c i") 'org-insert-todo-heading)
            (local-set-key (kbd "C-c t") 'org-toggle-blocks)))

(setq org-capture-templates
      '(
        ("l" "log" entry (file "log.org")
         "* %U\n %?\n" :empty-lines 1)

        ("n" "note" entry (file+headline "notes.org" "Work")
         "* %?\n%U\n" :empty-lines 1)
       )
)

(setq org-todo-keywords
      '((sequence "status(s)" "todo(t)" "|" "done(d)")
        (sequence "REMINDER(r)" "|")
        (sequence "|" "CANCELED(c)")))

;;(setq-default org-display-custom-times t)
;;(setq org-time-stamp-custom-formats '("<%Y-%b-%e %a %H:%M>" . "<%Y-%b-%e %a %H:%M>"))

(provide 'init-org)
