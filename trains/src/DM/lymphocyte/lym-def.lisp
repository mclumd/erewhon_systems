;; Time-stamp: <Mon Jan 13 18:31:46 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :pat-match
  (:use common-lisp cl-lib :sa-defs :logging) ; to handle my mods for structures.
  (:shadowing-import-from sa-defs #:between)
  (:export #:pat-match-toplevel #:fail #:no-bindings #:pvariable-p #:get-binding #:binding-var #:binding-val #:lookup
           #:segment-pattern-p #:$is #:$or #:$and #:$not #:$+ #:$* #:$** #:$? #:$if #:make-pvariable
           #:$boe #:$eoe #:$boi #:$eoi
           #:pvariable-name #:pvariable-type #:pvariable-collection-p #:+pvariable-collection+
           #:pat-match-abbrev #:expand-pat-match-abbrev #:rule-based-translator
           New
           #:eval-with-bindings #:pvariable-dont-care-p #:+pvariable-dont-care+
           ;; special stuff, to handle structures
           #:make-psacc #:psacc-p #:psacc-slotname #:psacc-next #:psacc
           #:make-psval #:psval-p #:psval-value #:psval
           
           ;; types
           #:typecheck #:t-non-null
           ))

(defpackage :lymphocyte-internal
  (:nicknames :lymi)
  (:use common-lisp cl-lib :pat-match :sa-defs :logging)
  (:shadowing-import-from sa-defs #:between)
  (:export
   ;; defs
   #:*lymphocyte-rulebases* #:*lymphocyte-readtable* #:*current-rulebase* #:*li-package* 
   ;; engine
   #:run-lymphocyte #:complete-lymphocyte #:tight-lymphocyte 
   ;; language
   #:load-rulebase #:compile-rulebase #:add-rule #:define-rulebase #:in-rulebase #:with-rulebase #:add-action #:add-query
   #:with-arguments #:_
   #:foreach #:forsome #:forall #:$match
   
   ;; predefined-types
   #:t-non-null #:t-positive
   
   ;; optional field names
   #:cost= #:utility= #:benefit= #:explanation= #:prematch= #:local= #:postmatch= #:localeval= #:produces=
   
   ;; patterns
   #:$is #:$or #:$and #:$not #:$+ #:$* #:$** #:$? #:$if
   #:$boe #:$eoe #:$boi #:$eoi #:type #:utility #:cost #:benefit #:explanation #:prematch #:local 
   #:postmatch #:localeval #:produces #:pattern
   
   ;; debug
   #:trace-lym #:*trace-lym* #:trace-lym-rule #:untrace-lym-rule #:*trace-rules*
   ))

(defpackage :lymphocyte
  (:nicknames :lym)
  (:use common-lisp cl-lib :lymphocyte-internal :sa-defs :logging)
  (:shadowing-import-from sa-defs #:between)
  (:export
      ;; engine
   #:run-lymphocyte #:complete-lymphocyte #:tight-lymphocyte 
   ;; language
   #:load-rulebase #:compile-rulebase #:add-rule #:define-rulebase #:in-rulebase #:with-rulebase #:add-action #:add-query 
   #:with-arguments #:_ #:bind
   #:foreach #:forsome #:forall #:$match
   ;; patterns
   #:$is #:$or #:$and #:$not #:$+ #:$* #:$** #:$? #:$if
   #:$boe #:$eoe #:$boi #:$eoi #:type #:utility #:cost #:benefit #:explanation #:prematch #:local 
   #:postmatch #:localeval #:produces #:pattern
   
      ;; optional field names
   #:cost= #:utility= #:benefit= #:explanation= #:prematch= #:local= #:postmatch= #:localeval= #:produces=

   ;; predefined-types
   #:t-non-null  #:t-positive
   
   ;;debug
   #:trace-lym #:*trace-lym* #:trace-lym-rule #:untrace-lym-rule #:*trace-rules*
   ))
