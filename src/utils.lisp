;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-

(defpackage cl-bible.utils
  (:use #:cl
        #:cl-bible)
  (:export
   :split-string-with-delimiter
   :download-bible-data))

(in-package :cl-bible.utils)

(defvar data-url "data/kjv.tsv")
(defvar data-cache-loc "/tmp/kjv-bible-data")

(defun download-bible-data ()
  "Checks to see if you already have the file in your /tmp dir otherwise to copy from the repository.
Moving the file to your temp directory to improve the portability of the application."
    (if (probe-file data-cache-loc)
      (print "File exists.")
      (uiop:copy-file data-url data-cache-loc)))

(defun split-string-with-delimiter (string
                                    &key (delimiter #\ )
                                    &aux (l (length string)))
  "Split string based on delimiter and create list."
  ;;https://stackoverflow.com/questions/59516459/split-string-by-delimiter-and-include-delimiter-common-lisp
  (loop :for start := 0 then (1+ pos)
        :for pos := (position delimiter string :start start)
        :when (and (null pos) (not (= start l)))
          :collect (subseq string start)
        :while pos
        :when (> pos start)
          :collect (subseq string start pos)))
