(defpackage cl-bible.os
  (:use #:cl
        #:cl-bible)
  (:export #:find-temp-dir))
(in-package :cl-bible.os)

;; TODO Change temp dir param depending on OS
;; Not priority currently as the focus is for Linux

(defvar find-temp-dir ()
  "Set where the temp data will be stored based on OS"
  ;; There may be a macro for this in UIOP
  (let ((os software-type))
    (cond (string= os "Linux") "/tmp/"
          (string= os "Windows") (error (c)
                                    (format t "This doesn't support Windows yet, please use a Linux Distro.~&")
                                    (values nil c)))))
