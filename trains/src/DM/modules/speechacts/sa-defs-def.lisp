;; Time-stamp: <Mon Jan 13 16:43:37 EST 1997 ferguson>
(in-package :cl-user)

(defpackage sa-defs (:use common-lisp cl-lib :kqml)
            (:shadowing-import-from kqml #:comment)
            (:shadow #:between)
            (:export
             #:tt-assert
             
             #:copy-sa
             
             #:generic-comm-act #:generic-comm-act-p #:initiator #:mode #:reliability #:action #:setting #:syntax
             #:ps-state #:plan #:input
             #:compound-communications-act #:compound-communications-act-p #:make-compound-communications-act #:acts
             
             #:communications-act #:focus #:objects #:paths #:defs #:speech-act #:semantics #:noise
             #:communications-act-p #:speech-act-p #:social-context
      
             #:sa-tell #:sa-request-action #:sa-question #:sa-wait #:sa-reject #:sa-request #:sa-restart
             #:sa-tell-p #:sa-request-action-p #:sa-question-p #:sa-wait-p #:sa-reject-p #:sa-request-p #:sa-restart-p
             #:make-sa-tell #:make-sa-request-action #:make-sa-question #:make-sa-wait #:make-sa-reject #:make-sa-request #:make-sa-restart
             
             #:make-sa-point-with-mouse #:sa-point-with-mouse-p #:sa-point-with-mouse #:sa-break #:make-sa-break #:sa-break-p
             
             #:sa-expressive #:sa-apologize #:sa-null
             #:sa-expressive-p #:sa-apologize-p #:sa-null-p
             #:make-sa-expressive #:make-sa-apologize #:make-sa-null
             
             #:sa-warn #:sa-conversational-act #:sa-response #:sa-evaluation
             #:sa-warn-p #:sa-conversational-act-p #:sa-response-p #:sa-evaluation-p
             #:make-sa-warn #:make-sa-conversational-act #:make-sa-response #:make-sa-evaluation
             
             #:sa-close #:sa-greet #:sa-ambiguous #:sa-elaborate #:sa-suggest
             #:sa-close-p #:sa-greet-p #:sa-ambiguous-p #:sa-elaborate-p #:sa-suggest-p
             #:make-sa-close #:make-sa-greet #:make-sa-ambiguous #:make-sa-elaborate #:make-sa-suggest
             
             #:sa-wh-question #:sa-yn-question #:sa-confirm  #:sa-id-goal
	     #:sa-why-question #:sa-how-question
             #:sa-wh-question-p #:sa-yn-question-p #:sa-confirm-p #:sa-id-goal-p
	     #:sa-why-question-p #:sa-how-question-p
             #:make-sa-wh-question #:make-sa-yn-question #:make-sa-confirm #:make-sa-id-goal
	     #:make-sa-why-question #:make-sa-how-question
      
             #:sa-conditional #:condition #:condition-object-true #:condition-object-false
             #:sa-conditional-p
             #:make-sa-conditional 
             
             #:sa-nolo-comprendez #:sa-huh #:object #:expected-type #:nc-plan
             #:sa-nolo-comprendez-p #:sa-huh-p
             #:make-sa-nolo-comprendez #:make-sa-huh
             
             ;; the following can be contents of speech acts, as per NLU 2/e by James Allen
             ;; or part of a kb.
             #:kb-object #:kb-object-p #:name #:kb-for-reference-p
             #:proposition #:proposition-p #:parser-token
             #:n-ary-operator #:n-ary-operator-p
             #:1-ary-operator #:1-ary-operator-p
             #:2-ary-operator #:2-ary-operator-p #:make-operator #:find-operator
             #:operator #:operator-p #:make-operator #:quantifier #:quantifier-p #:make-quantifier #:find-quantifier
             #:vari #:vari-p #:make-vari #:vclass #:vsort
             #:prop-prop #:prop-prop-p
             #:operator-prop #:operator-prop-p #:propositions #:make-operator-prop
             #:quantifier-prop #:quantifier-prop-p #:make-quantifier-prop
             #:arity
             #:predicate #:type-predicate #:1-ary-predicate #:2-ary-predicate #:n-ary-predicate #:make-predicate #:find-predicate
             #:make-type-predicate #:pred-for-reference-p #:pred-type-p
             
             #:make-predicate-prop #:predicate-prop-p #:predicate-prop
             #:terms #:collection #:collection-p #:make-collection #:collection-disjunct-p 
             
             ;; preestablished predicates
             #:*from-pred*
             #:*other-pred*
             
             ;; path quatna
             #:path-quantum #:path-quantum-p #:make-path-quantum  #:copy-path-quantum
             #:engine #:from #:to #:via #:not-via #:not-to #:not-from #:beyond #:not-beyond
             #:between #:not-between #:predicates #:preferences
             #:touched-p #:use
             ))
