;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-
;;;
;;; cl-bible - A library for reading and searching for bible passages from the King James Version
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
  (:use       :cl :asdf)
  (:import-from #:cl-bible.utils
                #:split-string-with-delimiter)
  (:import-from #:cl-bible.books
                #:update-books-list
                #:print-all-books)
  (:export    :get-bible-data
              :parse-bible-data
              :download-bible-data))
(in-package :cl-bible)

(defvar data-url "data/kjv.tsv")
(defvar data-cache-loc "/tmp/kjv-bible-data")
(defvar book-cache-loc "/tmp/kjv-bible-book-list")

(defparameter book-list nil)
(defparameter search-results nil)


(defun download-bible-data ()
  "Checks to see if you already have the file in your /tmp dir otherwise to copy from the repository.

Moving the file to your temp directory to improve the portability of the application."
    (if (probe-file data-cache-loc)
      (print "File exists.")
      (uiop:copy-file data-url data-cache-loc)))

;; (defun search-bible-data (&optional string)
(defun search-bible-data ()
  "Search bible data for STR or just return book data"
  (with-open-file (*standard-input* data-cache-loc)
    (loop :for line := (read-line *standard-input* nil)
          :while line
          :collect (split-string-with-delimiter line :delimiter #\Tab))))

(defun search-for-string(str)
  (princ "test"))
