(defpackage cl-bible.utils
  (:use #:cl
        #:cl-bible)
  (:export #:split-string-with-delimiter))
(in-package :cl-bible.utils)

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
