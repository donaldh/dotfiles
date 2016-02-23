;;; nmodl.el --- derived mode for Neuron NMODL dot-mod files
;;
;; Author: David C. Sterratt <david.c.sterratt@ed.ac.uk>
;; Maintainer: David C. Sterratt <david.c.sterratt@ed.ac.uk>
;; Created: 20 Apr 06
;; Version: 0.1.1
;; Keywords: NMODL, NEURON
;;
;; Copyright (C) 2006 David C. Sterratt
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
;;
;;; Commentary:
;;
;; This major mode for GNU Emacs provides support for editing Neuron NMODL
;; dot-mod files.  It automatically indents for block structures and
;; comments.  It highlights code using font-lock.
;;
;;; Finding Updates:
;;
;; The latest stable version of nmodl.el can be found here:
;;
;; http://www.anc.ed.ac.uk/~dcs/progs/neuron/nmodl.el
;;
;; To use nmodl.el, you also need to have downloaded and installed 
;; nrnhoc.el . It can be found at
;;
;; http://www.anc.ed.ac.uk/~dcs/progs/neuron/nrnhoc.el
;; 
;;; Installation:
;;
;;   Make sure you have obtain and installed nrnhoc.el
;;   
;;   Put the this file as "nmodl.el" somewhere on your load path, then
;;   add this to your .emacs or init.el file:
;;
;;   (autoload 'nmodl-mode "nmodl" "Enter NMODL mode." t)
;;   (setq auto-mode-alist (cons '("\\.mod\\'" . nmodl-mode) auto-mode-alist))
;;
;; Please read the mode help for nmodl-mode for configuration options.
;;
;; Syntax highlighting:
;;   To get font-lock try adding this for older emacsen:
;;     (font-lock-mode 1)
;;   Or for newer versions of Emacs:
;;     (global-font-lock-mode t)
;;   In Xemacs the following seems to work
;;     (add-hook 'nmodl-mode-hook 'turn-on-font-lock)
;;
;;
;; This package will optionally use custom.
;;

;;; Code:

(defconst nmodl-mode-version "0.1.1"
  "Current version of NMODL mode.")


;;; User-changeable variables =================================================

;; Variables which the user can change
(defgroup nmodl nil
  "NMODL mode."
  :prefix "nmodl-"
  :group 'languages)

(defcustom nmodl-mode-hook nil
  "*List of functions to call on entry to NMODL mode."
  :group 'nmodl
  :type 'hook)


;;; Syntax table ==============================================================

;; Defines comment font locking
(defvar nmodl-mode-syntax-table
  (let ((st (make-syntax-table)))
;;    (modify-syntax-entry ?_  "w" st)
    (modify-syntax-entry ?\n  ">" st)
    (modify-syntax-entry ?: "<" st)
    (modify-syntax-entry ?\^m  ">" st)
    st)
  "Syntax table for `nmodl-mode'.")

;;; Font locking keywords =====================================================

(defvar nmodl-font-lock-keywords
      '(
        ; Keywords (proc and func are syntax)
        ("\\<\\(COMMENT[[:ascii:]]+?ENDCOMMENT\\)\\>" . font-lock-comment-face)
        ("\\<\\(COMMENT\\|TITLE\\|UNITS\\|PARAMETER\\|ASSIGNED\\|CONSTANT\\|STATE\\|DERIVATIVE\\|INITIAL\\|BREAKPOINT\\|LOCAL\\|PROCEDURE\\|KINETIC\\|FUNCTION\\|ENDCOMMENT\\|DEFINE\\|NEURON\\|BEFORE\\|AFTER\\|NET_RECEIVE\\)\\>" . font-lock-keyword-face)
        ("\\<\\(FROM\\|TO\\|COMPARTMENT\\|SOLVE\||STEADYSTATE\\|METHOD\\|SUFFIX\\|USEION\\|READ\\|WRITE\\|GLOBAL\\|RANGE\\|LONGITUDINAL_DIFFUSION\\|LINEAR\\|NONLINEAR\\|SOLVE\\|POINT_PROCESS\\|NONSPECIFIC_CURRENT\\|STEADYSTATE\\|CONSERVE\\)\\>" . font-lock-keyword-face))
      "Expressions to highlight in NMODL mode.")

(define-derived-mode nmodl-mode
  nrnhoc-mode "Nmodl"
  "Major mode for Nmodl.
\\{nmodl-mode-map}"
  (setq case-fold-search nil)
  (set (make-local-variable 'comment-start-skip) ":+\\s-*")
  (set (make-local-variable 'comment-start) ": ")
  (set (make-local-variable 'font-lock-defaults)
       '(nmodl-font-lock-keywords))
  (run-hooks 'nmodl-mode-hook))

(provide 'nmodl) 	

