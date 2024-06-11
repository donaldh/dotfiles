;;; p4-16-mode.el --- Support for the P4_16 programming language -*- lexical-binding: t; -*-

;; Author: Soham S Gumaste <sohamg2@gmail.com>
;; Maintainer: Soham S Gumaste <sohamg2@gmail.com>
;; Version: 0.3
;; Created: 15 April 2017
;; Modifications bilicensed under the same license OR the MIT License.

;; Keywords: languages p4_16

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; P4 (Programming Protocol Independent Packet Processors) is a domain
;; specific language designed to program network fabric devices.
;; This mode has preliminary support for P4_16. It covers the core language,
;; but it is not clear yet, how we can highlight the indentifiers, defined
;; for a particular architecture.  Core library definitions are included

;;; History:

;; Original Source: https://github.com/p4lang/tutorials/blob/master/vm/p4_16-mode.el
;; Original License: Apache 2.0
;; Original Author: Vladimir Gurevich <vladimir.gurevich@barefootnetworks.com>

;;; Code:
(defvar p4-16-mode-hook nil)

;; Define the keymap (for now it is pretty much default)
(defvar p4-16-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "C-j") 'newline-and-indent)
    map)
  "Keymap for p4-16 major mode.")

;;; Syntactic Highlighting

;;;; Main keywords (declarations and operators)
(defconst p4-16-keywords
  '("action" "apply"
    "control"
    "default"
    "else" "enum" "extern" "exit"
    "header" "header_union"
    "if"
    "match_kind"
    "package" "parser"
    "return"
    "select" "state" "struct" "switch"
    "table"  "transition" "tuple" "typedef"
    "verify")
  "p4-16 Standard Keywords.")

(defconst p4-16-annotations
  '("@name" "@metadata" "@alias")
  "p4-16 Standard Annotations.")

(defconst p4-16-attributes
  '("const" "in" "inout" "out"
    ;; Tables
    "key" "actions" "default_action" "entries" "implementation"
    "counters" "meters")
  "p4-16 Object Attributes and Access Specifiers.")

(defconst p4-16-variables
  '("packet_in" "packet_out")
  "p4-16 Packet Types.")

(defconst p4-16-operations
  '("&&&" ".." "++" "?" ":")
  "p4-16 Operators.")

(defconst p4-16-constants
  '(;; Don't care
    "_"
    ;; bool
    "false" "true"
    ;; error
    "NoError" "PacketTooShort" "NoMatch" "StackOutOfBounds"
    "OverwritingHeader" "HeaderTooShort" "ParserTiimeout"
    ;; match_kind
    "exact" "ternary" "lpm" "range"
    ;; We can add constants for supported architectures here
    )
  "p4-16 Standard Constants.")

(defconst p4-16-types
  '("bit" "bool" "int" "varbit" "void" "error")
  "p4-16 Standard Datatypes.")

(defconst p4-16-primitives
  '(;; Header methods
    "isValid" "setValid" "setInvalid"
    ;; Table Methods
    "hit" "action_run"
    ;; packet_in methods
    "extract" "lookahead" "advance" "length"
    ;; packet_out methods
    "emit"
    ;; Known parser states
    "accept" "reject"
    ;; misc
    "NoAction")
  "p4-16 Standard Primitives.")

(defconst p4-16-cpp
  '("#include"
    "#define" "#undef"
    "#if" "#ifdef" "#ifndef"
    "#elif" "#else"
    "#endif"
    "defined"
    "#line" "#file"))

(defconst p4-16-cppwarn
  '("#error" "#warning"))

;; Optimize the strings
(defvar p4-16-keywords-regexp    (regexp-opt p4-16-keywords   'words))
(defvar p4-16-annotations-regexp (regexp-opt p4-16-annotations     1))
(defvar p4-16-attributes-regexp  (regexp-opt p4-16-attributes 'words))
(defvar p4-16-variables-regexp   (regexp-opt p4-16-variables  'words))
(defvar p4-16-operations-regexp  (regexp-opt p4-16-operations 'words))
(defvar p4-16-constants-regexp   (regexp-opt p4-16-constants  'words))
(defvar p4-16-types-regexp       (regexp-opt p4-16-types      'words))
(defvar p4-16-primitives-regexp  (regexp-opt p4-16-primitives 'words))
(defvar p4-16-cpp-regexp         (regexp-opt p4-16-cpp        1))
(defvar p4-16-cppwarn-regexp     (regexp-opt p4-16-cppwarn    1))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(defconst p4-16-font-lock-keywords
  (list                                        ;Perhaps use backquoting?
   (cons p4-16-cpp-regexp         font-lock-preprocessor-face)
   (cons p4-16-cppwarn-regexp     font-lock-warning-face)
   (cons p4-16-types-regexp       font-lock-type-face)
   (cons p4-16-constants-regexp   font-lock-constant-face)
   (cons p4-16-attributes-regexp  font-lock-builtin-face)
   (cons p4-16-variables-regexp   font-lock-variable-name-face)
   ;;; This is a special case to distinguish the method from the keyword
   (cons "\\.apply"               font-lock-function-name-face)
   (cons p4-16-primitives-regexp  font-lock-function-name-face)
   (cons p4-16-operations-regexp  font-lock-builtin-face)
   (cons p4-16-keywords-regexp    font-lock-keyword-face)
   (cons p4-16-annotations-regexp font-lock-keyword-face)
   (cons "\\(\\w*_t +\\)"      font-lock-type-face)
   (cons "[^A-Z_][A-Z] "       font-lock-type-face) ;; Total hack for templates
   (cons "<[A-Z, ]*>"          font-lock-type-face)
   (cons "\\(<[^>]+>\\)"       font-lock-string-face)
   (cons "\\([^_A-Za-z]\\([0-9]+w\\)?0x[0-9A-Fa-f]+\\)" font-lock-constant-face)
   (cons "\\([^_A-Za-z]\\([0-9]+w\\)?0b[01]+\\)"        font-lock-constant-face)
   (cons "\\([^_A-Za-z][+-]?\\([0-9]+w\\)?[0-9]+\\)"    font-lock-constant-face)
   ;;(cons "\\(\\w*\\)"        font-lock-variable-name-face)
   )
  "Default Highlighting Expressions for p4-16.")

(defvar p4-16-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry  ?_  "w"      st)
    (modify-syntax-entry  ?/  ". 124b" st)
    (modify-syntax-entry  ?*  ". 23"   st)
    (modify-syntax-entry  ?\n "> b"    st)
    st)
  "Syntax table for p4-16-mode.")

;;; Indentation
(defvar p4-16-indent-offset 4
  "Indentation offset for `p4-16-mode'.")

(defun p4-16-indent-line ()
  "Indent current line for any balanced-paren-mode'."
  (interactive)
  (let ((indent-col 0)
        (indentation-increasers "[{(]")
        (indentation-decreasers "[})]"))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list 1)
            (when (looking-at indentation-increasers)
              (setq indent-col (+ indent-col p4-16-indent-offset))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at indentation-decreasers)
                 (>= indent-col p4-16-indent-offset))
        (setq indent-col (- indent-col p4-16-indent-offset))))
    (indent-line-to indent-col)))

;; Put everything together
(defun p4-16-mode ()
  "Major mode for editing p4-16 programs."
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table p4-16-mode-syntax-table)
  (use-local-map p4-16-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(p4-16-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'p4-16-indent-line)
  (setq major-mode 'p4-16-mode)
  (setq mode-name "p4-16")
  (when (fboundp 'cscope-minor-mode) (cscope-minor-mode))
  (run-hooks 'p4-16-mode-hook))

(provide 'p4-16-mode)
;;; p4-16-mode.el ends here

