;;; raku-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "raku-detect" "raku-detect.el" (0 0 0 0))
;;; Generated autoloads from raku-detect.el

(add-to-list 'interpreter-mode-alist '("perl6\\|raku" . raku-mode))

(add-to-list 'auto-mode-alist '("\\.p[lm]?6\\'" . raku-mode))

(add-to-list 'auto-mode-alist '("\\.nqp\\'" . raku-mode))

(add-to-list 'auto-mode-alist '("\\.raku\\(?:mod\\|test\\)?\\'" . raku-mode))

(defconst raku-magic-pattern (rx line-start (0+ space) (or (and "use" (1+ space) "v6") (and (opt (and (or "my" "our") (1+ space))) (or "module" "class" "role" "grammar" "enum" "slang" "subset")))))

(autoload 'raku-magic-matcher "raku-detect" "\
Check if the current buffer is a Raku file.

Only looks at a buffer if it has a file extension of .t, .pl, or .pm.

Scans the buffer (to a maximum of 4096 chars) for the first non-comment,
non-whitespace line.  Returns t if that line looks like Raku code,
nil otherwise." nil nil)

(add-to-list 'magic-mode-alist '(raku-magic-matcher . raku-mode))

;;;***

;;;### (autoloads nil "raku-font-lock" "raku-font-lock.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from raku-font-lock.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-font-lock" '("raku-")))

;;;***

;;;### (autoloads nil "raku-imenu" "raku-imenu.el" (0 0 0 0))
;;; Generated autoloads from raku-imenu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-imenu" '("nqp-name-regex" "raku-")))

;;;***

;;;### (autoloads nil "raku-indent" "raku-indent.el" (0 0 0 0))
;;; Generated autoloads from raku-indent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-indent" '("raku-")))

;;;***

;;;### (autoloads nil "raku-mode" "raku-mode.el" (0 0 0 0))
;;; Generated autoloads from raku-mode.el

(autoload 'raku-mode "raku-mode" "\
Major mode for editing Raku code.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-mode" '("perl6-mode" "raku-mode-map")))

;;;***

;;;### (autoloads nil "raku-repl" "raku-repl.el" (0 0 0 0))
;;; Generated autoloads from raku-repl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-repl" '("raku-" "run-raku")))

;;;***

;;;### (autoloads nil "raku-skeletons" "raku-skeletons.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from raku-skeletons.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-skeletons" '("auth-id" "full-raku-path" "module-name" "raku-")))

;;;***

;;;### (autoloads nil "raku-unicode-menu" "raku-unicode-menu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from raku-unicode-menu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "raku-unicode-menu" '("menu-bar-final-items")))

;;;***

;;;### (autoloads nil nil ("raku-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; raku-mode-autoloads.el ends here
