(define-package "jupyter" "20200417.1907" "Jupyter"
  '((emacs "26")
    (zmq "0.10.3")
    (cl-lib "0.5")
    (simple-httpd "1.5.0")
    (websocket "1.9"))
  :commit "360cae2c70ab28c7a7848c0c56473d984f0243e5" :authors
  '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainer
  '("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")
  :url "https://github.com/dzop/emacs-jupyter")
;; Local Variables:
;; no-byte-compile: t
;; End:
