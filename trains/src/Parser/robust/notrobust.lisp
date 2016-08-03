(let ((grammar-files '("grammar/hierarchy"
		     "grammar/np-grammar"
		     "grammar/vp-grammar"
		     "grammar/values-grammar"
		     "grammar/newRules"
		     "grammar/noun-lex"
		     "grammar/verb-lex")))
  (make-grammar nil)
  (make-lexicon nil)
  (mapc #'load-smart grammar-files))
