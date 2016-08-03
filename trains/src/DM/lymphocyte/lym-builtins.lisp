(in-package lymphocyte)
;; Time-stamp: <95/06/13 17:14:01 miller>

;; predefine some rules.
(in-rulebase :predefined)

(with-syntax :lymphocyte
  (add-rule
   [* tSTART * [$boi]                       ; any level
      cost= 0
      benefit= 100])
  
  (add-rule
   [* tEND * [$eoi]                     ; won't work if we try to match all of the input with a pattern.
      cost= 0
      benefit= 100]))
