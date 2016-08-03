;; Time-stamp: <96/03/29 19:45:06 miller>
(in-package world-kb)

  (setup-city 'Jamestown 0 0)
  (setup-city 'Olean 4 0)
  (setup-city 'Franklinville 4 2)
  (setup-city 'Yorkshire 4 4)
  (setup-city 'East_Aurora  4 6)
  (setup-city 'Warsaw 6 5)
  (setup-city 'Mount_Morris 7 5)
  (setup-city 'Hornell 8 2)
  (setup-city 'Dansville 8 2)
  (setup-city 'Avon 8 6)
  (setup-city 'Rochester 8 10)
  (setup-city 'Bath 9 2)
  (setup-city 'Canandaigua 9 6)
  (setup-city 'Corning 10 0)
  (setup-city 'Penn_Yan 10 4)
  (setup-city 'Geneva 10 6)
  (setup-City 'Lyons 10 8)
  (setup-City 'Sodus 10 10)
  (setup-city 'Elmira 11 0)
  (setup-city 'Watkins_Glen 11 2)
  (setup-city 'Ithaca 12 2)
  (setup-city 'Fulton 12 10)
  
  (setup-track 'Jamestown 'Olean 4 4)
  (setup-track 'Olean 'Franklinville 2 2)
  (setup-track 'Franklinville 'Yorkshire 2 2)
  (setup-track 'Yorkshire 'East_Aurora 2 2)
  (setup-track 'East_Aurora 'Warsaw 3 3)
  (setup-track 'Warsaw 'Mount_Morris 1 1)
  (setup-track 'Mount_Morris 'Avon 2 2)
  (setup-track 'Avon 'Rochester 3 3)
  (setup-track 'Rochester 'Sodus 2 2)
  (setup-track 'Sodus 'Fulton 4 4)
  
  (setup-track 'Olean 'Hornell 4 4)
  (setup-track 'Hornell 'Bath 2 2)
  (setup-track 'Bath 'Dansville 3 3)
  (setup-track 'Dansville 'Mount_Morris 2 2)
  
  (setup-track 'Dansville 'Canandaigua 3 3)
  (setup-track 'Avon 'Canandaigua 3 3)
  (setup-track 'Canandaigua 'Geneva 2 2)
  (setup-track 'Geneva 'Lyons 2 2)
  (setup-track 'Geneva 'Penn_Yan 2 2)
  (setup-track 'Geneva 'Ithaca 4 4)
  
  (setup-track 'Bath 'Penn_Yan 3 3)
  (setup-track 'Penn_Yan 'Watkins_Glen 2 2)
  (setup-track 'Watkins_Glen 'Elmira 2 2)
  
  (setup-track 'Bath 'Corning 2 2)
  (setup-track 'Corning 'Elmira 1 1)
  (setup-track 'Elmira 'Ithaca 2 2)
  
  ;; change as of 1/16/95
  (setup-track 'Lyons 'Sodus 2 2)