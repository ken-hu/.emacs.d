;; ccls
;;(use-package lsp-mode :commands lsp)
;;(use-package lsp-ui :commands lsp-ui-mode)
;;(use-package company-lsp :commands company-lsp)
;;
;;(use-package ccls
;;  :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;         (lambda () (require 'ccls) (lsp))))
;;
;;(setq ccls-executable "/usr/local/bin/ccls")

;;;;; LSP: generic language server protocol support for Emacs ;;;;;

(use-package lsp-mode
  :ensure t
  :diminish
  :config
  (setq lsp-auto-guess-root t
        ;; Prefer flycheck to flymake.  I don't know what the deal is with
        ;; flymake but it seems to go into a "Wait" state and not update the
        ;; buffer stats quite often: I need to save the buffer to kickstart it
        ;; again.  Also in the *Flymake log* I see lots of weird errors from
        ;; make commands I don't recognize.
        lsp-prefer-flymake nil
        ;; Kill the server when the last buffer in the workspace is deleted.
        ;; If you are indexing everything you might reconsider this as
        ;; restarting the server can be slow.  On the other hand, leaving
        ;; those servers around when they're not needed uses a lot of
        ;; resources, so...
        lsp-keep-workspace-alive nil
        ;; If we don't use full indexing in ccls (see ccls config below) then
        ;; we don't want to watch files either.  lsp-mode will ask the server
        ;; to update any file if it is changed in Emacs.
        lsp-enable-file-watchers nil
        )

  ;; Don't watch directories containing temporary files, etc.
  ;; Another option is to (setq lsp-enable-file-watchers nil) to disable
  ;; file watching completely.
  (setq lsp-file-watch-ignored '("[/\\\\]\\.git$"
                                 "[/\\\\]\\..*cache"
                                 "[/\\\\]CMakeFiles$"
                                 "[/\\\\]target$"
                                 "[/\\\\]obj$"
                                 "[/\\\\]tmp$"
                                 "[/\\\\]dist$"
                                 "[/\\\\]package$")
        ;; There are about 15,500 files in the nuodb Git repository
        lsp-file-watch-threshold 17000)

  ;; We need to use this instead of c-mode-common-hook etc. so it can
  ;; obey file-local and directory-local variable settings.
  (add-hook 'hack-local-variables-hook
            (lambda () (when (derived-mode-p 'c-mode 'c++-mode) (lsp))))
  ;; LSP requires this to be loaded; it won't be used at all otherwise
  (require 'projectile)
)

;; Mark the variable as safe so we can override it in .dir-locals.el
;;(put 'lsp-file-watch-ignored 'safe-local-variable 'listp)

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-enable nil))

;;;;; EMACS-CCLS: ccls language server integration ;;;;;

(use-package ccls
  :ensure t
  :after lsp-mode
  :config
  ;; This uses nuodb-3rdparty which is set in nuodb.el
  (setq ccls-initialization-options
        `(
          :clang (:resourceDir
                  "/Library/Developer/CommandLineTools/usr/lib/clang/10.0.1"
                  ;;:extraArgs
                  ;;(
                  ;; ,(concat "-isystem " "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/Library/Developer/CommandLineTools/usr/include/c++/v1")
                  ;; ,(concat "--sysroot=" "/Library/Developer/CommandLineTools")
                  ;; ,(concat "--sysroot=" "/usr/local/Cellar/llvm/9.0.1")
                  ;; )
                  )
          :index (:threads 6
                  ;; Disable full indexing.  This allows ccls to use
                  ;; significantly less resources, but it also means we can't
                  ;; use features that require full cross-referencing.
                  ;; What I'd like to do is figure out how to force this, so
                  ;; we can start with this for workspaces we just want to
                  ;; visit quickly, then run a command to fully-index
                  ;; workspaces that we want to use "in anger".
                  :initialBlacklist (".")
                  )
          )
        ;; Enable for debugging
        ;;ccls-args '("--log-file=/tmp/ccls.out" "-v=2")
        ;; Set the binary path
        ccls-executable "/usr/local/bin/ccls"
        ))

;; Mark the variable as safe so we can override it in .dir-locals.el
;;(put 'ccls-initialization-options 'safe-local-variable 'listp)

(provide 'init-lsp-ccls)
