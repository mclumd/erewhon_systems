(setf (current-problem)
      (create-problem
       (name mutant-conference)
       (objects
	(Researcher   Person)
	(ResearchPass Passport)
	(AKR          Presentation)
	)
       (state (and (at-o AKR          Kinkos)
		   (at-o ResearchPass PostOffice)
		   (at-p Researcher   PostOffice)
		   (in-p Researcher   Atlanta)
		   )
	      )
       (goal (and
	      (in-p Researcher Iraklion)
	      (holding Researcher AKR)
	      )
	     )
       )
      )


