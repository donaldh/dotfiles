;;; casual-org.el --- Transient UI for org-mode -*- lexical-binding: t; -*-

(require 'transient)
(require 'org)
(require 'casual-lib)

;;;###autoload (autoload 'casual-org-tmenu "casual-org" nil t)

(transient-define-prefix casual-org-tmenu ()
  "Transient menu for org-mode"

  [["Org"
    ("a" "Agenda..." org-agenda :transient nil)
    ("b" "Babel›" casual-org-babel-tmenu :transient nil)
    ("d" "Deft search..." deft :transient nil)
    ("p" "Publish..." org-publish :transient nil)
    ("w" "Refile..." org-refile :transient nil)
    ("." "Timestamp" org-timestamp :transient nil)
    ]
   ["Table"
    ("|" "Create..." org-table-create-or-convert-from-region :transient nil)
    ]
   ["Slides"
    ("r" "Reveal export" my-org-reveal-export :transient nil)
    ]
   ["Mobile"
    ("<" "Pull" org-mobile-pull :transient nil)
    (">" "Push" org-mobile-push :transient nil)
    ]
   ["Roam"
    ("i" "Insert node..." org-roam-node-insert :transient nil)
    ("n" "Find node..." org-roam-node-find :transient nil)
    ]])

(transient-define-prefix casual-org-babel-tmenu ()
  "Transient menu for Org Babel functions."
  ["Babel"
   [("I" "Src block info" org-babel-view-src-block-info :transient nil)
   ("b" "Execute buffer" org-babel-execute-buffer :transient nil)
   ("c" "Check src block" org-babel-check-src-block :transient nil)
   ("d" "Demarcate block" org-babel-demarcate-block :transient nil)
   ("e" "Execute maybe" org-babel-execute-maybe :transient nil)
   ("f" "Tangle file" org-babel-tangle-file :transient nil)
   ("g" "Goto src block..." org-babel-goto-named-src-block :transient nil)
   ("i" "LoB ingest" org-babel-lob-ingest :transient nil)
   ("j" "Insert header arg..." org-babel-insert-header-arg :transient nil)
   ("k" "Remove result" org-babel-remove-result-one-or-many :transient nil)]
   [("l" "Load in session" org-babel-load-in-session :transient nil)
   ("n" "Next src block" org-babel-next-src-block :transient nil)
   ("o" "Open result" org-babel-open-src-block-result :transient nil)
   ("p" "Previous src block" org-babel-previous-src-block :transient nil)
   ("r" "Goto result..." org-babel-goto-named-result :transient nil)
   ("s" "Execute subtree" org-babel-execute-subtree :transient nil)
   ("t" "Tangle" org-babel-tangle :transient nil)
   ("u" "Go to src head" org-babel-goto-src-block-head :transient nil)
   ("v" "Expand src block" org-babel-expand-src-block :transient t)
   ]])

(defun my-org-reveal-export ()
  "Export slides using org-re-reveal and display them in the browser"
  (interactive)
  (require 'org-re-reveal)
  (let ((enable-local-variables :all))
    (hack-local-variables)
    (org-re-reveal-export-to-html-and-browse)))

(provide 'casual-org)
;;; casual-org.el ends here
