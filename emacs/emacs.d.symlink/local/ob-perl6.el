;;; ob-perl6.el --- Babel Functions for Perl 6  -*- lexical-binding: t; -*-
;;; -*- lexical-binding: t; -*-

;; This file is NOT part of GNU Emacs.

;;; Commentary:
;; Org-Babel support for evaluating Perl 6 source code.

;;; Code:

(require 'map) ;; for `map-filter'
(require 'ob)
(defvar org-babel-tangle-lang-exts)
(add-to-list 'org-babel-tangle-lang-exts
             '("perl6" . "pl6"))

(defvar org-babel-perl6-command "perl6 -e '$*IN.slurp.EVAL'"
  "Name of command to use for executing Perl 6 code.")

(defun org-babel-execute:perl6 (body params)
  "Execute a block of Perl 6 code with Babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((session       (cdr (assq :session params)))
         (result-params (cdr (assq :result-params params)))
         (result-type   (cdr (assq :result-type params)))
         (full-body (org-babel-expand-body:generic
                     body params (org-babel-variable-assignments:perl6 params)))
         (session (org-babel-perl6-initiate-session session)))
    (org-babel-reassemble-table
     (org-babel-perl6-evaluate session full-body result-type result-params)
     (org-babel-pick-name
      (cdr (assq :colname-names params)) (cdr (assq :colnames params)))
     (org-babel-pick-name
      (cdr (assq :rowname-names params)) (cdr (assq :rownames params))))))

(defun org-babel-prep-session:perl6 (_session _params)
  "Prepare SESSION according to the header arguments in PARAMS."
  (error "Sessions are not supported for Perl 6"))

(defun org-babel-variable-assignments:perl6 (params)
  "Return list of perl statements assigning the block's variables."
  (mapcar
   (lambda (pair) (org-babel-perl6--var-to-perl6 (cdr pair) (car pair)))
   (mapcar 'cdr (map-filter (lambda (k v) (eq :var k)) params))))

;; helper functions
;; (defvar org-babel-perl6-var-wrap "q«%s»"
;;   "Wrapper for variables inserted into Perl 6 code.")

(defvar org-babel-perl6--lvl)
(defun org-babel-perl6--value-to-perl6 (value &optional name)
  "Convert an elisp VALUE names NAME to a Perl 6 variable."
  (if name
      (let ((org-babel-perl6--lvl 0)
            (lvar (listp value)))
        (concat
         "my $"
            (symbol-name name) "=" (when lvar "\n")
              (org-babel-perl6--value-to-perl6 value) ";\n"))
    (let ((prefix (make-string (* 2 org-babel-perl6--lvl) ?\ )))
      (concat prefix
              (if (listp value)
                  (let ((org-babel-perl6--lvl (1+ org-babel-perl6--lvl)))
                    (concat "("
                            (mapconcat #'org-babel-perl6--value-to-perl6 value "")
                            ")")
                    )
                (format "'%s'" value))
              (unless (zerop org-babel-perl6--lvl) ",\n")))))

(defvar org-babel-perl6-buffers '(:default . nil))

(defun org-babel-perl6-initiate-session (&optional _session _params)
  "Return nil because sessions are not supported by Perl 6."
  nil)

(defvar org-babel-perl6-dump-template "
    BEGIN { $*OUT  = '%s'.IO.open(:w) }
    use Data::Dump;
    my &code = sub { %s };
    print Dump(code(), :!color);
")

(defvar org-babel-perl6-verbatim-template "
    BEGIN { $*OUT = '%s'.IO.open(:w) }
    my &code = sub { %s };
    code();
")

(defvar org-babel-perl6-value-template "
    BEGIN { $*OUT = '%s'.IO.open(:w) }
    my &code = sub { %s };
    say do given my $r = code() {
      when Any:U {
         $r.^name
      }
      when Positional | Seq {
         $r.join: \"\t\"
      }
      default {
         $r
      }
    }
")

(defvar org-babel-perl6-preface nil)

(defun org-babel-perl6-evaluate (session ibody &optional result-type result-params)
  "Pass BODY to the Perl 6 process in SESSION.
If RESULT-TYPE equals `output' then return a list of the outputs
of the statements in BODY, if RESULT-TYPE equals `value' then
return the value of the last statement in BODY, as elisp."
  (when session (error "Sessions are not supported for Perl 6"))
  (let* ((body (concat org-babel-perl6-preface ibody))
         (tmp-file (org-babel-temp-file "perl6-"))
         (tmp-babel-file (org-babel-process-file-name
                          tmp-file 'noquote)))
    (let ((results
           (pcase result-type
             (`output
              (org-babel-eval org-babel-perl6-command
                              (format org-babel-perl6-verbatim-template tmp-babel-file body )
                              )
              )
             (`value
              (cond
               ((member "pp" result-params)
                (org-babel-eval org-babel-perl6-command
                                (format org-babel-perl6-dump-template tmp-babel-file body)))
               (t
                (org-babel-eval org-babel-perl6-command
                                (format org-babel-perl6-value-template
                                        tmp-babel-file body))))))))
      (when results
        (org-babel-result-cond result-params
          (org-babel-eval-read-file tmp-file)
          (org-babel-import-elisp-from-file tmp-file '(16)))))))

(provide 'ob-perl6)
;;; ob-perl6.el ends here
