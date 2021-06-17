;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-

(defpackage cl-bible.verses
  (:use #:common-lisp
        #:cl-bible)
  (:export
   :print-all-bible-data))

(in-package :cl-bible.books)

(defvar data-cache-loc "/tmp/kjv-bible-data")

(defun print-all-bible-data ()
  "Return all verses formatted in list format"
  (with-open-file (*standard-input* data-cache-loc)
    (loop :for line := (read-line *standard-input* nil)
          :while line
          :collect (split-string-with-delimiter line :delimiter #\Tab))))
