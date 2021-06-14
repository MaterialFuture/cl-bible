;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-
;;;
;;; cl-bible - Bible script for reading and searching for bible passages from the King James Version
;;;
;;; Copyright © 2021 Konstantine V @Materialfuture
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the
;;; "Software"), to deal in the Software without restriction, including
;;; without limitation the rights to use, copy, modify, merge, publish,
;;; distribute, sublicense, and/or sell copies of the Software, and to
;;; permit persons to whom the Software is furnished to do so, subject to
;;; the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included
;;; in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
;;; OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(defpackage   #:cl-bible
  (:nicknames :bible)
  (:use       #:common-lisp)
  (:export    :get-bible-data
              :parse-bible-data
              :download-bible-data
              :update-books-list
              :print-all-books))

(defvar data-url "data/kjv.tsv")
(defvar data-cache-loc "/tmp/kjv-bible-data")
(defvar book-cache-loc "/tmp/kjv-bible-book-list")

(defparameter book-list nil)
(defparameter search-results nil)

;; TODO Change temp dir param depending on OS
;; Not priority ;)
;; (defvar find-temp-dir ()
;;   (let ((os software-type))
;;     (cond (string= os "Linux") "/tmp/"
;;           (string= os "Windows") (error (c)
;;                                     (format t "This doesn't support Windows yet, please use a Linux Distro.~&")
;;                                     (values nil c)))))

(defun download-bible-data ()
  "Checks to see if you already have the file in your /tmp dir otherwise to copy from the repository."
    (if (probe-file data-cache-loc)
      (print "File exists.")
      (uiop:copy-file data-url data-cache-loc)))

;;https://stackoverflow.com/questions/59516459/split-string-by-delimiter-and-include-delimiter-common-lisp
(defun split-string-with-delimiter (string
                                    &key (delimiter #\ )
                                    &aux (l (length string)))
  "Split string based on delimiter and create list."
  (loop :for start := 0 then (1+ pos)
        :for pos := (position delimiter string :start start)
        :when (and (null pos) (not (= start l)))
        :collect (subseq string start)
        :while pos
        :when (> pos start) :collect (subseq string start pos)))

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
      (and (download-bible-data)
           (update-books-list))))

(defun print-all-books ()
  "Prints all book names from BOOKS-LIST or name.
If cached books file exists then print that, otherwise run UPDATE-BOOKS-LIST and return the list of books."
  (if (probe-file book-cache-loc)
        (with-open-file (*standard-input* book-cache-loc)
          (loop :for line := (read-line *standard-input* nil) :while line :collect line))
      (and (update-books-list)
           (print book-list))))

(defun search-bible-data (&optional string)
  "Search bible data for STR or just return book data"
  (with-open-file (*standard-input* data-cache-loc)
    (loop :for line := (read-line *standard-input* nil)
          :while line
          :collect (split-string-with-delimiter line :delimiter #\Tab))))

(defun search-for-string(str)
  (princ "test"))
