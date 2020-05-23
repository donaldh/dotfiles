;;; ob-raku.el --- Babel Functions for Raku
;;; -*- lexical-binding: t; -*-

;; This file is NOT part of GNU Emacs.

;;; Commentary:
;; Org-Babel support for evaluating Raku source code.

;;; Code:

(require 'map) ;; for `map-filter'
(require 'ob)
(defvar org-babel-tangle-lang-exts)
(add-to-list 'org-babel-tangle-lang-exts
             '("raku" . "raku"))

(defvar org-babel-raku-command "rakudo -e '$*IN.slurp.EVAL'"
  "Name of command to use for executing Raku code.")

(defun org-babel-execute:raku (body params)
  "Execute a block of Raku code with Babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((session       (cdr (assq :session params)))
         (result-params (cdr (assq :result-params params)))
         (result-type   (cdr (assq :result-type params)))
         (full-body (org-babel-expand-body:generic
                     body params (org-babel-variable-assignments:raku params)))
         (session (org-babel-raku-initiate-session session)))
    (org-babel-reassemble-table
     (org-babel-raku-evaluate session full-body result-type result-params)
     (org-babel-pick-name
      (cdr (assq :colname-names params)) (cdr (assq :colnames params)))
     (org-babel-pick-name
      (cdr (assq :rowname-names params)) (cdr (assq :rownames params))))))

(defun org-babel-prep-session:raku (session params)
  "Prepare SESSION according to the header arguments in PARAMS."
  (save-window-excursion
    (let ((buffer (org-babel-raku-initiate-session session)))
      (org-babel-comint-in-buffer buffer
        (mapc (lambda (line)
                (insert line)
                (comint-send-input nil t))
              (org-babel-variable-assignments:raku params)))
      (current-buffer))))

(defun org-babel-variable-assignments:raku (params)
  "Return list of Raku statements assigning the block's variables."
  (mapcar
   (lambda (pair) (org-babel-raku--var-to-raku (cdr pair) (car pair)))
   (mapcar 'cdr (map-filter (lambda (k v) (eq :var k)) params))))

;; helper functions
;; (defvar org-babel-raku-var-wrap "q«%s»"
;;   "Wrapper for variables inserted into Raku code.")

(defvar org-babel-raku--lvl)
(defun org-babel-raku--value-to-raku (value &optional name)
  "Convert an elisp VALUE names NAME to a Raku variable."
  (if name
      (let ((org-babel-raku--lvl 0)
            (lvar (listp value)))
        (concat
         "my $"
            (symbol-name name) "=" (when lvar "\n")
              (org-babel-raku--value-to-raku value) ";\n"))
    (let ((prefix (make-string (* 2 org-babel-raku--lvl) ?\ )))
      (concat prefix
              (if (listp value)
                  (let ((org-babel-raku--lvl (1+ org-babel-raku--lvl)))
                    (concat "("
                            (mapconcat #'org-babel-raku--value-to-raku value "")
                            ")")
                    )
                (format "'%s'" value))
              (unless (zerop org-babel-raku--lvl) ",\n")))))

(defvar org-babel-raku-buffers '(:default . nil))

(defun org-babel-raku-initiate-session (&optional session _params)
  "Initiate a session named SESSION acoording to PARAMS."
  "Return nil because sessions are not supported by Raku."
  (when (and session (not (string= session "none")))
    (save-window-excursion
      (or (org-babel-comint-buffer-livep session)
          (progn
            (get-buffer-create session)
            (make-comint-in-buffer "raku" session "perl6"))))))

(defvar org-babel-raku-dump-template "
    BEGIN { $*OUT  = '%s'.IO.open(:w) }
    use Data::Dump;
    my &code = sub { %s };
    print Dump(code(), :!color);
")

(defvar org-babel-raku-verbatim-template "
    BEGIN { $*OUT = '%s'.IO.open(:w) }
    my &code = sub { %s };
    code();
")

(defvar org-babel-raku-value-template "
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

(defvar org-babel-raku-preface nil)

(defun org-babel-raku-evaluate (session ibody &optional result-type result-params)
  "Pass BODY to the Raku process in SESSION.
If RESULT-TYPE equals `output' then return a list of the outputs
of the statements in BODY, if RESULT-TYPE equals `value' then
return the value of the last statement in BODY, as elisp."
;  (when session (error "Sessions are not supported for Raku"))
  (let* ((body (concat org-babel-raku-preface ibody))
         (tmp-file (org-babel-temp-file "raku-"))
         (tmp-babel-file (org-babel-process-file-name
                          tmp-file 'noquote)))
    (let ((results
           (pcase result-type
             (`output
              (org-babel-eval org-babel-raku-command
                              (format org-babel-raku-verbatim-template tmp-babel-file body )
                              )
              )
             (`value
              (cond
               ((member "pp" result-params)
                (org-babel-eval org-babel-raku-command
                                (format org-babel-raku-dump-template tmp-babel-file body)))
               (t
                (org-babel-eval org-babel-raku-command
                                (format org-babel-raku-value-template
                                        tmp-babel-file body))))))))
      (when results
        (org-babel-result-cond result-params
          (org-babel-eval-read-file tmp-file)
          (org-babel-import-elisp-from-file tmp-file '(16)))))))


(provide 'ob-raku)
;;; ob-raku.el ends here
