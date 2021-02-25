;;; ob-vega.el --- Babel Functions for vega-lite     -*- lexical-binding: t; -*-

;; Author: Donald Hunter
;; Keywords: literate programming, reproducible research
;; Homepage: https://orgmode.org

;; Based on ob-dot.el from GNU Emacs

;; Copyright (C) 2009-2020 Free Software Foundation, Inc.

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-Babel support for evaluating vega-lite source code.
;;
;; For information on vega see https://vega.github.io/vega-lite/
;;
;; This differs from most standard languages in that
;;
;; 1) there is no such thing as a "session" in vega
;;
;; 2) we are generally only going to return results of type "file"
;;
;; 3) we are adding the "file" and "cmdline" header arguments
;;
;; 4) there are no variables (at least for now)

;;; Code:
(require 'ob)

(add-to-list 'org-src-lang-modes '("vega" . "json"))

(defvar org-babel-default-header-args:vega
  '((:results . "file") (:exports . "results"))
  "Default arguments to use when evaluating a vega source block.")

(defun org-babel-expand-body:vega (body params)
  "Expand BODY according to PARAMS, return the expanded body."
  (let ((vars (org-babel--get-vars params)))
    (mapc
     (lambda (pair)
       (let ((name (symbol-name (car pair)))
	     (value (cdr pair)))
	 (setq body
	       (replace-regexp-in-string
		(concat "$" (regexp-quote name))
		(if (stringp value) value (format "%S" value))
		body
		t
		t))))
     vars)
    body))

(defun org-babel-execute:vega (body params)
  "Execute a block of Vega code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((out-file (cdr (or (assq :file params)
			    (error "You need to specify a :file parameter"))))
	 (cmdline (or (cdr (assq :cmdline params))
		      (format "-T%s" (file-name-extension out-file))))
	 (cmd (or (cdr (assq :cmd params)) "vl2svg"))
	 (coding-system-for-read 'utf-8) ;use utf-8 with sub-processes
	 (coding-system-for-write 'utf-8)
	 (in-file (org-babel-temp-file "vega-")))
    (with-temp-file in-file
      (insert (org-babel-expand-body:vega body params)))
    (org-babel-eval
     (concat cmd
	     " " (org-babel-process-file-name in-file)
;;	     " " cmdline
	     " " (org-babel-process-file-name out-file)) "")
    nil)) ;; signal that output has already been written to file

(defun org-babel-prep-session:vega (_session _params)
  "Return an error because Vega does not support sessions."
  (error "Vega does not support sessions"))

(provide 'ob-vega)

;;; ob-vega.el ends here
