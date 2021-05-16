;;; Bible script for reading and searching for bible passages

(ql:quickload '("yason"
                "trivial-download"))

;;; Parameters
;; (defparameter *bible* "King James Version")
;; (defparameter *bible-abbr* 'kjv)
;; (defparameter *book-name* 'Genesis)
;; (defparameter *book-abbr* 'gen)
(defparameter *book-num* 1)
(defparameter *book-abrv* 'gen)
(defparameter *chapter-num* 001)
(defparameter *verse-num* 001)

(defparameter *bible-data* nil)
(defparameter *current-ch-data* nil)

(defvar data-url "https://raw.githubusercontent.com/scrollmapper/bible_databases/master/json/t_kjv.json")
(defvar json-data-cache-loc "$HOME/.cache/")

;;; Main Functions

(defun get-bible-data () ; "https://raw.githubusercontent.com/thiagobodruk/bible/master/json/en_kjv.json"
  ;; if download success then do yason parse
  (trivial-download:download data-url
                             json-data-cache-loc)
  (setq *bible-data*
    (reverse
     (yason:parse
       json-data-cache-loc
      ;; (dex:get "https://raw.githubusercontent.com/scrollmapper/bible_databases/master/json/t_kjv.json" :want-stream t) ; online get method
; TODO find way to store file in ~/.cache for linux
; Have both JSON and list formats available in cache
       :object-as :alist
       :json-arrays-as-vectors t))))

;; Checks
(defun get-current-verseid ()
  (princ *verseid*))

;;; Navigation
;; TODO Since Yason converts json to lists then try to navigate the list in a way that makes sense
;; If I decide to provide a buffer or some sort of bookmark system then the (setq x (+ x 1)) system is nice to keep track of things
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
  "Prints all book names so users can quickly navigate"
  ;TODO programatically generate this from the list
  (format t "Print all the book names plus numbers, (ie. 1.  Genesis...)"))

