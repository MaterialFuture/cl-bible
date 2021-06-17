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

;; TODO - Finish main functions

(defun search-books (book)
  "Search the books in the bible based on PRINT-ALL-BOOKS"
  (format T "~d" book))

(defun search-verse (book verse)
  "Search bible for verse and return
TODO: parse verse for colons"
  (format T "~s, ~s" book verse))

(defun search-bible (string)
  "Search all of bible for string and return all matching cases as list of strings"
  (format T "~s" string))
