;; Save buffer when file is modified
;; Used when switching buffers, exiting evil-insert-state
(defun my-save-if-bufferfilename ()
  (if (buffer-file-name)
      (progn
        (save-buffer)
        )
    )
)

;; Switch to previously open buffer.
;; Repeated invocations toggle between the two most recently open buffers.
(defun switch-to-previous-buffer ()
  (interactive)
  (my-save-if-bufferfilename)
  (switch-to-buffer (other-buffer (current-buffer) 1))
)

(global-set-key (kbd "C-x p") 'switch-to-previous-buffer)

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-x C-o") 'ff-find-other-file)))

(provide 'init-global-functions)
