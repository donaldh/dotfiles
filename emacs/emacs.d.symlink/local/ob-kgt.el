;;; ob-kgt.el --- Babel Functions for kgt     -*- lexical-binding: t; -*-

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

;; Org-Babel support for evaluating kgt source code.
;;
;; For information on kgt see https://github.com/katef/kgt
;;
;; This differs from most standard languages in that
;;
;; 1) there is no such thing as a "session" in kgt

;;; Code:
(require 'ob)

(defvar org-babel-default-header-args:kgt
  '((:results . "output") (:exports . "results"))
  "Default arguments to use when evaluating a kgt source block.")

(defun org-babel-expand-body:kgt (body params)
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

(defun org-babel-execute:kgt (body params)
  "Execute a block of Kgt code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((infmt (or (cdr (assq :in params)) "bnf"))
         (outfmt (or (cdr (assq :out params)) "rrutf8"))
	 (cmd (or (cdr (assq :cmd params)) "kgt"))
	 (coding-system-for-read 'utf-8) ;use utf-8 with sub-processes
	 (coding-system-for-write 'utf-8))
    (with-temp-buffer
      (insert
       (org-babel-eval
        (concat cmd " -l " infmt " -e " outfmt) (org-babel-expand-body:kgt body params)))
      (buffer-string))))

(defun org-babel-prep-session:kgt (_session _params)
  "Return an error because Kgt does not support sessions."
  (error "Kgt does not support sessions"))

(provide 'ob-kgt)

;;; ob-kgt.el ends here
