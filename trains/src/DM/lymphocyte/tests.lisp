(in-package lymphocyte)

(set-syntax :lymphocyte)

(defun debug-patterns (&key types vars structs extensions)
  (trace pat-match::pat-match)          ; always want this
  (trace pat-match::first-match-pos)
  (if types
      (trace pat-match::typecheck))
  (if vars
      (trace pat-match::match-variable))
  (if structs
      (trace pat-match::structure-matcher))
  (if extensions
      (trace pat-match::extended-segment-match-i)))

(debug-patterns :types t :extensions t)
  

(setq t-foo [* t-foo t-bar [?*bunch-of-junk :foo ?*more-junk]
               utility= 1
               cost= 1])

(lymi::patternmatch-one t-foo '(:a b (c d e) :foo i (j k))) ; should succeed

(lymi::patternmatch-one t-foo '(:a b (c d e) :bar i (j k))) ; should fail

;; now try structures

(setq t-via [0 t-via * [$boe ^paths=[?*junk1 ^via=?via@t-non-null ?*junk2] $eoe]]) ; some via slot

(lymi::patternmatch-one t-via (list (make-sa-question :paths (list (make-path-quantum :from :avon) (make-path-quantum :via :bath) (make-path-quantum :to :rochester))))) ; should succeed, binding ?via to :bath.

;; simple extended pattern

(setq t-via-ex [0 t-via * 
                  [$boe 
                   ^paths=[($* ?vias@t-non-null ?*_^via=nil ?_@t-non-null^via=?via@t-non-null) ?*_^via=nil]
                   $eoe]])

(setq t-via-ex** [0 t-via * 
                       [$boe
                        ^paths=[($** ^via=?vias@t-non-null)]
                        $eoe]])

(setq test-pattern (list (make-sa-question :paths (list (make-path-quantum :from :avon)
                                                        (make-path-quantum :via :bath)
                                                        (make-path-quantum :to :rochester)
                                                        (make-path-quantum :via :lyons)
                                                        (make-path-quantum :via :sodus)))))

(lymi::patternmatch-one t-via-ex test-pattern)

(defun test-patternmatch ()
  (dotimes (x 1000)
    (lymi::patternmatch-one t-via-ex test-pattern)))
    
(time (test-patternmatch))

;; now try with (new, original!) $**

(lymi::patternmatch-one t-via-ex** test-pattern)

(defun test-patternmatch** ()
  (dotimes (x 1000)
    (lymi::patternmatch-one t-via-ex** test-pattern)))

(time (test-patternmatch**))


(eval-when (load eval)
  (define-rulebase :test))

(in-rulebase :test)

;; a simple test to make sure we can match sets of rules.

(defparameter *test-input* (make-sa-question :paths (list (make-path-quantum :from :jamestown :to :bath) (make-path-quantum :via :yorkshire) (make-path-quantum :to :ithaca :via :geneva) (make-path-quantum :to :fulton :not-via :elmira))))

(add-rule
 [0 (r-all-vias ?all-vias) * 
    [$boe
     ^paths=[($** ^via=?all-vias@t-non-null)]
     $eoe]])

(add-rule
 [0 (r-all-froms ?all-froms) * 
    [$boe
     ^paths=[($** ^from=?all-froms@t-non-null)]
     $eoe]])

(add-rule
 [0 (r-all-tos ?all-tos) * 
    [$boe
     ^paths=[($** ^to=?all-tos@t-non-null)]
     $eoe]])

(add-rule
 [0 (r-subpaths ?subpath) *
    [$boe
     ^paths=[($+ ?subpath ;; better to do this with lisp fn.
                 ($? ^from=?from@t-non-null)
                 ($? ^via=?via@t-non-null)
                 ($? ^to=?to@t-non-null)
                 ?_ 
                 ($* ?subpath1 ^from=nil ^to=nil ($* ^via=?via1@t-non-null) ?_))]
     $eoe]])



