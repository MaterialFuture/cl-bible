;;; Bible script for reading and searching for bible passages

(defpackage #:scripts.cl-bible
  (:use #:uiop #:common-lisp)
  (:export :get-bible-data
           :parse-bible-data))

(ql:quickload "trivial-download")

;; (defvar data-url "https://raw.githubusercontent.com/scrollmapper/bible_databases/master/json/t_kjv.json")
(defvar data-url "https://raw.githubusercontent.com/LukeSmithxyz/kjv/master/kjv.tsv")
(defvar data-cache-loc "/tmp/kjv-bible-data.txt")

;; TODO Change temp dir param depending on OS
;; (defparameter temp-dir nil)
;; (defun find-temp-dir
;;   (setq (let ((os software-type))
;;     (cond (string= os "Linux") "/tmp/"
;;           (string= os "Windows") (error (c)
;;                                     (format t "This doesn't support Windows yet, please use a Linux Distro.~&")
;;                                     (values nil c))))))
  

;;; Main Functions
(defun download-bible-data ()
  "Download the kjv bible data in plaintext format"
  (trivial-download:download data-url data-cache-loc))

(defun check-file-exists ()
  "Check to ensure that file exists (could be refactored to just PROBE-FILE)."
  (if (probe-file (make-pathname :directory '(:absolute "/tmp/") :name "kjv-bible-data.txt"))
      (print "File exists.")
      (print "Doesn't exist.")))

(defun parse-bible-data (&optional str)
  "Parse bible data based on str or just return book data"
   (uiop:read-file-string "/tmp/kjv-bible-data.txt"))

(defvar bible-books-list
  ;TODO optionally have func programatically update this list from the plaintext file
  ;ie, get each line, grab string up to first tab char, put in list, remove dupes
  '("Genesis"))

(defun update-book-list ()
  (print "Read TODO in BIBLE-BOOKS-LIST"))

(defun print-all-book-names ()
  "Prints all book names based on BIBLE-BOOKS-LIST"
  (format t "~A~%" bible-books-list))

