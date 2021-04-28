;;; Bible script for reading and searching for bible passages

(ql:quickload '("yason" "dexador"))

;;; Parameters

;; (defparameter *bible* "King James Version")
;; (defparameter *bible-abbr* 'kjv)
;; (defparameter *book-name* 'Genesis)
;; (defparameter *book-abbr* 'gen)
(defparameter *book-num* 1)
(defparameter *chapter-num* 001)
(defparameter *verse-num* 001)
(defparameter *verseid* 1001001 )

;;; Main Functions
 
(defun get-file (file)
  (reverse
   (yason:parse
    (dex:get file :want-stream t)
    :object-as :alist
    :json-arrays-as-vectors t)))

;; Checks
(defun get-current-verseid ()
  (princ *verseid*))

(defun check-verseid ())
  ;; compare verseid from param or from current and check if valid before going to next one 

;;; Navigation
;;; 
;; Verses
(defun next-verse ()
  ;; (setq (*verseid* (+ *verseid* 1)))
  (setq *verse-num* (+ *verse-num* 1)))
  ;; add conditional to check the next number before setting the verseid

(defun prev-verse ()
  ;; (setq (*verseid* (+ *verseid* 1)))
  (setq *verse-num* (- *verse-num* 1)))
  ;; add conditional to check the next number before setting the verseid

;; Chapters
(defun next-chapter ()
  (setq *chapter-num* (+ *chapter-num* 1)))
  ;; add conditional to check the next number before setting the verseid

(defun prev-chapter ()
  (setq *chapter-num* (- *chapter-num* 1)))


;;; Main Prints
;;; 
;; (defun print-verses (n)
  ;; n as chapter num, get all verses within it
  ;; for optimization, chunk +-10 at a time and show that way
  ;; )


(defun print-all-book-names ()
  (format t "Print all the book names plus numbers, (ie. 1.  Genesis...)"))

