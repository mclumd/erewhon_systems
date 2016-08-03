;; Time-stamp: <Mon Jan 13 16:41:20 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :kqml
  (:use common-lisp cl-lib logging)
  (:shadow #:comment #:name #:to #:from)
  (:export #:*local-modules* 
           #:*interest-alist*
           #:*kqml-sender* #:*kqml-recipient* #:*kqml-reply-with* #:*kqml-re*; automate some handshaking
           #:*print-for-kqml*
           ;; #:*thread* #:*current-cookies* #:message-wrapper #:thread #:cookies
           ;; #:default-message #:message #:generic-message #:gm-message-name #:gm-message-args 
           ;;#:copy-generic-message #:create-gm 
           
           #:sorry
           
           #:internal-module-p
           
           #:copy-kqml
           
           #:fix-pkg
           
           #:kb-request #:kb-request-kqml
           
           #:kqml-performative #:kqml-performative-p #:perf #:content #:force #:in-reply-to #:language #:ontology #:receiver
           #:sender #:reply-with #:code #:aspect #:order #:undefined #:comment ;;  #:name #:to #:from  
           #:re
           #:create-kqml #:create-request #:create-tell #:create-broadcast #:register #:register-interest 
           #:create-evaluate #:create-ask-about #:create-ask-if #:create-ask-one #:create-ask-all
           #:create-gm-request #:create-reply #:create-error
           
           #:kqml-problem-p
           ))
