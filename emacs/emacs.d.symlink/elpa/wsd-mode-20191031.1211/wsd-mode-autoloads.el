;;; wsd-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "company-wsdmode" "company-wsdmode.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from company-wsdmode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-wsdmode" '("company-wsd-mode" "wsd-")))

;;;***

;;;### (autoloads nil "ob-wsdmode" "ob-wsdmode.el" (0 0 0 0))
;;; Generated autoloads from ob-wsdmode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ob-wsdmode" '("org-babel-")))

;;;***

;;;### (autoloads nil "wsd-core" "wsd-core.el" (0 0 0 0))
;;; Generated autoloads from wsd-core.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wsd-core" '("wsd-")))

;;;***

;;;### (autoloads nil "wsd-flycheck" "wsd-flycheck.el" (0 0 0 0))
;;; Generated autoloads from wsd-flycheck.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wsd-flycheck" '("wsd-flycheck-")))

;;;***

;;;### (autoloads nil "wsd-mode" "wsd-mode.el" (0 0 0 0))
;;; Generated autoloads from wsd-mode.el

(autoload 'wsd-mode "wsd-mode" "\
Major-mode for websequencediagrams.com

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.wsd$" . wsd-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wsd-mode" '("wsd-")))

;;;***

;;;### (autoloads nil nil ("wsd-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; wsd-mode-autoloads.el ends here
