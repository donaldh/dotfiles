;;; cpputils-cmake-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cpputils-cmake" "cpputils-cmake.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from cpputils-cmake.el

(autoload 'cppcm-get-exe-path-current-buffer "cpputils-cmake" nil t nil)

(autoload 'cppcm-version "cpputils-cmake" nil t nil)

(autoload 'cppcm-compile "cpputils-cmake" "\
Compile the executable/library in current directory,
default compile command or compile in the build directory.
You can specify the sequence which compile is default
by customize `cppcm-compile-list'.

\(fn &optional PREFIX)" t nil)

(autoload 'cppcm-recompile "cpputils-cmake" "\
Run 'make clean && compile'." t nil)

(autoload 'cppcm-reload-all "cpputils-cmake" "\
Reload and reproduce everything." t nil)

(register-definition-prefixes "cpputils-cmake" '("cppcm-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cpputils-cmake-autoloads.el ends here
