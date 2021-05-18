;;; Bible script for reading and searching for bible passages

(defpackage #:cl-bible
  (:nicknames :bible)
  (:use #:common-lisp)
  (:export :get-bible-data
           :parse-bible-data))

(ql:quickload "trivial-download")
;TODO refactor by creating own macro for downloads
;Alternatively, just include file in repo

(defvar data-url "https://raw.githubusercontent.com/LukeSmithxyz/kjv/master/kjv.tsv")
(defvar data-cache-loc "/tmp/kjv-bible-data.txt")
(defvar book-cache-loc "/tmp/kjv-bible-book-list.txt")

;; TODO Change temp dir param depending on OS
;; Not priority ;)
;; (defvar find-temp-dir ()
;;   (let ((os software-type))
;;     (cond (string= os "Linux") "/tmp/"
;;           (string= os "Windows") (error (c)
;;                                     (format t "This doesn't support Windows yet, please use a Linux Distro.~&")
;;                                     (values nil c)))))
  

;;; Main Functions
(defun download-bible-data ()
  "Download the kjv bible data in plaintext format"
  (if (probe-file data-cache-loc)
      (print "File exists.")
      (trivial-download:download data-url data-cache-loc)))

(defun check-file-exists ()
  "Check to ensure that file exists (could be refactored to just PROBE-FILE)."
  (if (probe-file data-cache-loc)
      (print "File exists.")
      (print "Doesn't exist.")))

(defun parse-bible-data (&optional str)
  "Parse bible data based on str or just return book data"
  (with-open-file (*standard-input* data-cache-loc)
    (loop :for read-line := (read-line *standard-input* nil) :while read-line :collect read-line)))

(defvar bible-books-list '("Genesis"
                           "Exodus"
                           "Leviticus"))
  ;TODO optionally have func programatically update this list from the plaintext file
  ;ie, get each line, grab string up to first tab char, put in list, remove dupes

(defun update-books-list ()
  "Update the list of books and save into a file.
Parse main data file and create text document for displaying the books.
The purpose of this is based on if I (or others) decide to update the main file with new books - ie septuigent etc."
  (if (probe-file data-cache-loc)
      (lambda ()
        (print "File exists."))
      ;TODO Create check so the below doesn't loop
      (and (download-bible-data)
           (update-books-list))))

(defun print-all-book-names ()
  "Prints all book names based on BIBLE-BOOKS-LIST"
  (if (probe-file book-cache-loc)
      ;TODO write lambda func for generating printing contents of text file 
      (lambda ()
        (print "File exists."))
      (format t "~A~%" bible-books-list)))

