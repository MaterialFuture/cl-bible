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
(defparameter book-list nil)

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

(defun update-books-list ()
  "Update the list of books and save into a file.
Parse main data file and create text document for displaying the books based on what the bible data is - if formatting is correct.
The purpose of this is based on if I (or others) decide to update the main file with new books - ie septuigent etc."
  (if (probe-file data-cache-loc)
      (and (setq book-list (with-open-file (*standard-input* data-cache-loc)
        (loop :for line := (read-line *standard-input* nil)
              :while line
              :collect (first (split-string-with-delimiter line :delimiter #\Tab)))))
           (and (setq book-list (delete-duplicates book-list :test #'string-equal))
                (with-open-file (file #P"/tmp/kjv-bible-book-list.txt"
                                      :direction :output
                                      :if-exists :append
                                      :if-does-not-exist :create)
                   (dolist (line book-list)
                     (write-line line file)))))
      
      (and (download-bible-data)
           (update-books-list))))

;;https://stackoverflow.com/questions/59516459/split-string-by-delimiter-and-include-delimiter-common-lisp
(defun split-string-with-delimiter (string
                                    &key (delimiter #\ )
                                    &aux (l (length string)))
  (loop for start = 0 then (1+ pos)
        for pos   = (position delimiter string :start start)
        when (and (null pos) (not (= start l)))
        collect (subseq string start)
        while pos
        when (> pos start) collect (subseq string start pos)))

(defun print-all-book-names ()
  "Prints all book names from BOOKS-LIST or name.
If cached books file exists then print that, otherwise run UPDATE-BOOKS-LIST and return the list of books."
  (if (probe-file book-cache-loc)
        (with-open-file (*standard-input* book-cache-loc)
          (loop :for line := (read-line *standard-input* nil) :while line :collect line))      
        (and (update-books-list)
             (print book-list))))

