  (in-package "PARSER")  
(setq *lexicon-engine-NAME*
      (expand 'NAME 
        '(:node
          ((AGR 3s) (NAME +) (CLASS ENGINE))
          ((:node 
            ((SEM ENGINE))
            ((:leaf metroliner)
	     (:leaf kennedy)(:leaf clinton)(:leaf reagan)(:leaf gorbachev)
	     (:leaf northstar)
             (:leaf bullet)))
           ))
        ))
(augment-lexicon *lexicon-engine-NAME*)
