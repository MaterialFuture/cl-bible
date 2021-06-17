;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-

(defpackage #:cl-bible
  (:use :cl :asdf))

(in-package :cl-bible)

(defsystem "cl-bible"
  :name "Bible Library"
  :version "0.1.0"
  :author "MaterialFuture"
  :maintainer "MaterialFuture"
  :license "GPLv3"
  :depends-on (:uiop)
  :pathname "src/"
  :components ((:file "./utils")
               (:file "./books" :depends-on ("./utils")
               (:file "./verses")))
  :description "Bible library"
  :long-description "A library for reading and searching for bible passages from the King James Version")
