;; ----------------------------------------------------------------------------
;; NuoDB Coding Style for Emacs
;;
;; Paul Smith <psmith@nuodb.com>
;;
;; The best way to customize this mode is to first load this file as-is,
;; then add another mode-hook that will make the changes you prefer.

(defvar nuodb-c-version "1.1"
  "Version of the NuoDB C/C++/Java style configuration.")

(message "Loading nuodb Elisp package version %s" nuodb-c-version)

(defvar nuodb-3rdparty (or (getenv "THIRDPARTY_DIR")
                           (concat (expand-file-name "~") "/nuo3rdparty")))
(defvar nuodb-target (cond ((string= system-type "windows-nt") "x86_32-windows")
                           ((string= system-type "darwin")    "x86_64-darwin")
                           ((string= system-type "gnu/linux") "x86_64-linux")))


;;;; CC-MODE General Configuration ;;;;

;; Create the NuoDB CC mode style.  Start with K&R.
(defconst nuodb-c-style
  '("k&r" ; Start with standard K&R
    ;; -- REQUIRED by the coding standard --

    ;; Basic offset is 4 spaces
    (c-basic-offset . 4)

    ;; Only reindent if tab is pressed in the indentation
    (c-tab-always-indent . nil)

    ;; Modifications to standard K&R style
    (c-offsets-alist        . ((inline-open    . 0)
                               (case-label     . +)))

    ;; Clean up whitespace
    (c-cleanup-list         . (brace-else-brace
                               brace-elsif-brace
                               brace-catch-brace
                               empty-defun-braces
                               defun-close-semi
                               list-close-comma))

    ;; Add a special hook to handle FOR_*/END_FOR indentation
    (c-special-indent-hook  . (nuodb-special-indent-hook))

    ;; -- OPTIONAL (disable if you don't want it) --

    ;; Display syntactic information in the minibuffer
    (c-echo-syntactic-information-p . t)
    )
  "NuoDB C/C++ Coding Style"
  )
(c-add-style "nuodb" nuodb-c-style)

;; Customize all of CC Mode modes (C, C++, Java)
(defun nuodb-c-mode-common-hook ()
  ;; Use the NuoDB style we defined above
  (c-set-style "nuodb")

  ;; Auto-fill comments
  (auto-fill-mode 1)

  ;; Move by individual CamelCase words
  (subword-mode 1)

  ;; Show matching parens via faces not blinking
  (show-paren-mode 1)

  ;; Automatically insert some newlines
  ;(c-toggle-auto-newline 1)

  ;; Delete all whitespace, not just one space
  ;(c-toggle-hungry-state 1)
  )

(add-hook 'c-mode-common-hook 'nuodb-c-mode-common-hook)

;;;; Whitespace ;;;;

;; Add this to the mode hook for any mode where using NuoDB whitespace rules
(defun nuodb-whitespace-hook ()
  ;; Make whitespace problems visible
  (setq whitespace-action '(auto-cleanup warn-if-read-only)
        whitespace-style  '(face trailing empty tabs tab-mark
                            indentation space-after-tab space-before-tab))
  (whitespace-mode 1)
  )

;;;; C/C++ ;;;;

;; In NuoDB, .h files are treated as C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Instruct Emacs on handling our weird FOR_* / END_FOR macros.
;; We create a special indentation function to handle them.

(setq nuodb-macro-names-start "\\<FOR_\\(HASH\\|OBJECTS\\|STACK\\|SYNTAX\\|FIELDS\\|INDEXES\\)\\>")
(setq nuodb-macro-names-stop "\\<END_FOR\\>")

(defun nuodb-special-indent-hook ()
  (let ((statement (assq 'statement c-syntactic-context))
        for-anchor for-end)
    (when statement
      ;; This is a statement, so see if it's in a FOR_* / END_FOR context
      (save-excursion
        (setq for-end (progn (back-to-indentation)
                             (looking-at-p nuodb-macro-names-stop))
              for-anchor (progn (goto-char (cadr statement))
                                (looking-at-p nuodb-macro-names-start))))
      ;; Based on what we discovered, handle reindation (or not)
      (if for-anchor
          (unless for-end (c-shift-line-indentation c-basic-offset))
        (when for-end
          (c-shift-line-indentation (- c-basic-offset)))))))

;; The basic mode hook, for both C and C++
(defun nuodb-c-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width        8)

  ;; Tell CC Mode that FOR_* / END_FOR macros are "statements"
  (setq c-macro-names-with-semicolon
        (concat "\\(" nuodb-macro-names-start "\\|" nuodb-macro-names-stop "\\)"))
  (c-make-macro-with-semi-re)
  )

(add-hook 'c-mode-hook 'nuodb-c-mode-hook)
(add-hook 'c++-mode-hook 'nuodb-c-mode-hook)

(add-hook 'c-mode-hook 'nuodb-whitespace-hook)
(add-hook 'c++-mode-hook 'nuodb-whitespace-hook)

;;;; JAVA ;;;;

(defun nuodb-java-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width        8)
  )

(add-hook 'java-mode-hook 'nuodb-java-mode-hook)
(add-hook 'java-mode-hook 'nuodb-whitespace-hook)

;;;; PYTHON ;;;;

(defun nuodb-python-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width        8)

  ;; Move by individual CamelCase words
  (subword-mode 1)

  ;; Show matching parens via faces not blinking
  (show-paren-mode 1)
  )

(add-hook 'python-mode-hook 'nuodb-python-mode-hook)
(add-hook 'python-mode-hook 'nuodb-whitespace-hook)

;;;; SHELL ;;;;

(add-hook 'sh-mode-hook 'nuodb-whitespace-hook)

;;;; COMPILATION ;;;;

;; Provide the ability to compile from the root directory.
;; Bind this to a different key than 'compile, or run it directly via M-x
(defun compile-workspace ()
  "Compile the entire workspace from the top."
  (interactive)
  (let* ((git-root (locate-dominating-file default-directory ".git"))
         (compile-command
          (if git-root (or (gethash git-root compile-workspace-commands)
                           (concat "make -C " git-root " -k "))
            compile-command)))

    ;; Do it!
    (call-interactively 'compile)

    ;; If this is a Git repo command remember it
    (if git-root
      (puthash git-root compile-command compile-workspace-commands))
    ))

;; Assoc list where the key is the .git directory name and the value is
;; the compile command we last used there.
(defvar compile-workspace-commands (make-hash-table :test 'equal)
  "Remember edited compile-workspace commands.")


;;;; CMAKE ;;;;

(add-to-list 'load-path (concat nuodb-3rdparty
                                "/common/cmake/share/editors/emacs"))
(require 'cmake-mode)
(setq auto-mode-alist (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                                ("\\.cmake\\'" . cmake-mode))
                              auto-mode-alist))

(defun nuodb-cmake-mode-hook ()
  (setq cmake-tab-width 4)
  (modify-syntax-entry ?_  "_")
  )

(add-hook 'cmake-mode-hook 'nuodb-cmake-mode-hook)


;; ----------------------------------------------------------------------------
(provide 'nuodb)
;; ----------------------------------------------------------------------------
