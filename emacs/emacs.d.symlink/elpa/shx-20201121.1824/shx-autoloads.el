;;; shx-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "shx" "shx.el" (0 0 0 0))
;;; Generated autoloads from shx.el

(autoload 'shx-mode "shx" "\
Toggle shx-mode on or off.

If called interactively, toggle `Shx mode'.  If the prefix
argument is positive, enable the mode, and if it is zero or
negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

The mode's hook is called both when the mode is enabled and when
it is disabled.

This minor mode provides extra functionality to shell-mode and
comint-mode in general.  Use `shx-global-mode' to enable
`shx-mode' in all buffers that support it.

Provides the following key bindings: 
\\{shx-mode-map}

\(fn &optional ARG)" t nil)

(put 'shx-global-mode 'globalized-minor-mode t)

(defvar shx-global-mode nil "\
Non-nil if Shx-Global mode is enabled.
See the `shx-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `shx-global-mode'.")

(custom-autoload 'shx-global-mode "shx" nil)

(autoload 'shx-global-mode "shx" "\
Toggle Shx mode in all buffers.
With prefix ARG, enable Shx-Global mode if ARG is positive; otherwise, disable it.  If called
from Lisp, enable the mode if ARG is omitted or nil.

Shx mode is enabled in all buffers where `shx--global-on' would do it.

See `shx-mode' for more information on Shx mode.

\(fn &optional ARG)" t nil)

(autoload 'shx "shx" "\
Create a new shx-enhanced shell session.
The new buffer is called NAME and uses DIRECTORY as its `default-directory'.
See the function `shx-mode' for details.

\(fn &optional NAME DIRECTORY)" t nil)

(register-definition-prefixes "shx" '("shx-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; shx-autoloads.el ends here
