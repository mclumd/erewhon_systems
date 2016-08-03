;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Program:	X-ANALOGY: Experimental Extensions For		;;
;;			PRODIGY/ANALOGY				;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Class:	CS8503: Guided Research				;;
;; Assignment:	Thesis Research Implementation			;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Experimental Analogy Extensions			;;
;; File:	"x-analogy.lisp"				;;
;;--------------------------------------------------------------;;
;; Notes:	This file is the master loader for X-Analogy.	;;
;;--------------------------------------------------------------;;
;; History:	12may97 Michael Cox added load of            	;;
;;              x-analogy-support.lisp (that rewrites some of   ;;
;;              the retrieval code) and x-merge-eval.lisp that  ;;
;;              was used to perform evaluation on various merge ;;
;;              strategies and includes the select merge        ;;
;;              function used by the UI.                        ;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;; 1. Load Submodules.						;;
;;**************************************************************;;
(in-package "USER")

;;**************************************************************;;
;; 1. Load Submodules						;;
;;**************************************************************;;
(defvar *x-analogy-pathname* 
  (concatenate 'string *analogy-pathname*
	       "Development/"))


(load (merge-pathnames "loadtrace" *x-analogy-pathname*))
(load (merge-pathnames "x-retrieval" *x-analogy-pathname*))
(load (merge-pathnames "x-replay" *x-analogy-pathname*))
(load (merge-pathnames "x-step" *x-analogy-pathname*))
(load (merge-pathnames "x-analogy-support" *x-analogy-pathname*))
(load (merge-pathnames "x-merge-eval" *x-analogy-pathname*))
