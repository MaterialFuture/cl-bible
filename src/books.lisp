(defpackage cl-bible.books
  (:use #:common-lisp
        #:cl-bible)
  (:local-nicknames (:utils :cl-bible.utils))
  (:export
   :update-books-list
   :print-all-books))

(in-package :cl-bible.books)

(defvar data-cache-loc "/tmp/kjv-bible-data")
(defvar book-cache-loc "/tmp/kjv-bible-book-list")

(defparameter book-list nil)
(defparameter search-results nil)

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
             (with-open-file (file book-cache-loc
                                   :direction :output
                                   :if-exists :append
                                   :if-does-not-exist :create)
               (dolist (line book-list)
                 (write-line line file)))))
      (and (utils:download-bible-data)
           (update-books-list))))

(defun print-all-books ()
  "Prints all book names from BOOKS-LIST or name.
If cached books file exists then print that, otherwise run UPDATE-BOOKS-LIST and return the list of books."
  (if (probe-file book-cache-loc)
        (with-open-file (*standard-input* book-cache-loc)
          (loop :for line := (read-line *standard-input* nil) :while line :collect line))
      (and (update-books-list)
           (print book-list))))
