(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; So org-capture works
(setq org-default-notes-file "~/Dropbox/org/capture.org")
(setq org-directory "~/Dropbox/org")
;; Open a file
(global-set-key (kbd "C-c o t") (lambda() (interactive) (find-file "~/Dropbox/org/todo.org")))
(global-set-key (kbd "C-c o n") (lambda() (interactive) (find-file "~/Dropbox/org/notes.org")))
;; Code block highlight in orgmode
(setq org-src-fontify-natively t)
;; #+STARTUP: showeverything
(setq org-startup-folded nil)

(setq org-capture-templates
      '(
        ("t" "TODO tasks" entry (file "todo.org")
         "* TODO%?\n%u\n" :empty-lines 1)

        ("n" "NOTE" entry (file+headline "notes.org" "Work")
         "* %?\n%u\n" :empty-lines 1)

        ("c" "CheckBox" checkitem (file+headline "checkbox.org" "Checkbox")
         "[ ] %?\n%u\n" :empty-lines 1)
       )
)

;;(setq org-todo-keywords
;;      '((sequence "TODO(t)" "|" "DONE(d)")
;;        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;;        (sequence "|" "CANCELED(c)")))

(provide 'init-org)
