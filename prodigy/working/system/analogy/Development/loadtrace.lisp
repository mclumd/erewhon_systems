;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Program:	LOADTRACE: Microutility Package			;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Class:	CS9000: Doctoral Thesis				;;
;; Assignment:	Thesis Research Implementation			;;
;; Due:		Before Defense					;;
;;--------------------------------------------------------------;;
;; Module:	Loadtrace Program				;;
;; Author:	Anthony G. Francis, Jr.				;;
;;--------------------------------------------------------------;;
;; Notes: Load this package with:				;;
;;	(unless (boundp '*load-trace*) (load "loadtrace"))	;;
;;--------------------------------------------------------------;;
;;**************************************************************;;
(in-package "USER")
(export '(*load-trace* loadtrace))

;;--------------------------------------------------------------;;
;; VARIABLE *load-trace*					;;
;;--------------------------------------------------------------;;
;; Notes: toggles the printing of trace info on variable and	;;
;;--------------------------------------------------------------;;
(defparameter *load-trace* nil)

;;--------------------------------------------------------------;;
;; FUNCTION *load-trace*					;;
;;--------------------------------------------------------------;;
;; Notes: A wrapper for (format *load-trace* "~%Stuff..")	;;
;;--------------------------------------------------------------;;
(defun loadtrace (&rest notification)
  (apply #'format *load-trace* notification))

;;--------------------------------------------------------------;;
;; NOTIFICATION load tracing initialization			;;
;;--------------------------------------------------------------;;
;; Notes: Let the user know this is active.			;;
;;--------------------------------------------------------------;;
(when *load-trace* 
      (format *load-trace* "~%[activating load tracing system]"))