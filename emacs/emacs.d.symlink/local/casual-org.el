;;; casual-org.el --- Transient UI for org-mode -*- lexical-binding: t; -*-

(require 'transient)
(require 'org)
(require 'casual-lib)

;;;###autoload (autoload 'casual-org-tmenu "casual-org" nil t)

(transient-define-prefix casual-org-tmenu ()
  "Transient menu for org-mode"

  [["Org"
    ("a" "Agenda..." org-agenda :transient nil)
    ("d" "Deft search..." deft :transient nil)
    ("p" "Publish..." org-publish :transient nil)
    ]
   ["Mobile"
    ("<" "Pull" org-mobile-pull :transient nil)
    (">" "Push" org-mobile-push :transient nil)
    ]
   ["Roam"
    ("i" "Insert node..." org-roam-node-insert :transient nil)
    ("n" "Find node..." org-roam-node-find :transient nil)
    ]])

(provide 'casual-org)
;;; casual-org.el ends here
