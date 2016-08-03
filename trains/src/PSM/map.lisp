;; Time-stamp: <96/02/12 18:29:16 ferguson>

(in-package "PSM")

;;  These should be deleted when re-integrating back into trains

(defun setup-city (x y z) (DR-setup-city x y z))
(defun setup-city-alias (x y) nil)
(defun setup-track (x y) (DR-setup-track x y))
(reset-map)
  ;; new cities
  ;;Here's the list of objects for the northeast map. You can run
  ;;/u/ferguson/research/toytrains/tt to see it until I do some more work
  ;;to allow multiple versions to be installed.
  ;;
  ;;George
  ;;
  ;;# Canvas size 762x726
  (setup-city 'Albany 596 170)
  ;;:create :city :name Albany :orientation northwest \
  ;;	:shape :circle :thickness -1 :center [596,170] :radius  5

  (setup-city 'Atlanta 237 704)
  ;;:create :city :name Atlanta :orientation west \
  ;;	:shape :circle :thickness -1 :center [237,704] :radius  7

  (setup-city 'Baltimore 525 359)
  ;;:create :city :name Baltimore :orientation west \
  ;;	:shape :circle :thickness -1 :center [525,359] :radius  5

  (setup-city 'Buffalo 400 200)
  ;;:create :city :name Buffalo :orientation southeast \
  ;;	:shape :circle :thickness -1 :center [400,200] :radius  5

  (setup-city 'Burlington 608 73)
  ;;:create :city :name Burlington :orientation east \
  ;;	:shape :circle :thickness -1 :center [608,73] :radius  5

  (setup-city 'Boston 701 155)
  ;;:create :city :name Boston :orientation northwest \
  ;;	:shape :circle :thickness -1 :center [701,155] :radius  7

  (setup-city 'Charleston 334 458)
  ;;:create :city :name Charleston :orientation southwest \
  ;;	:shape :circle :thickness -1 :center [334,458] :radius  5

  (setup-city 'Charlotte 397 618)
  ;;:create :city :name Charlotte :orientation east \
  ;;	:shape :circle :thickness -1 :center [397,618] :radius  5

  (setup-city 'Chicago 60 300)
  ;;:create :city :name Chicago :orientation west \
  ;;	:shape :circle :thickness -1 :center [60,300] :radius  7

  (setup-city 'Cincinnati 213 433)
  ;;:create :city :name Cincinnati :orientation southeast \
  ;;	:shape :circle :thickness -1 :center [213,433] :radius  5
  (setup-city-alias 'Cincinnati 'Cincy)
  (setup-city 'Cleveland 302 297)
  ;;:create :city :name Cleveland :orientation south \
  ;;	:shape :circle :thickness -1 :center [302,297] :radius  5

  (setup-city 'Columbus 245 359)
  ;;:create :city :name Columbus :orientation southeast \
  ;;	:shape :circle :thickness -1 :center [245,359] :radius  5

  (setup-city 'Detroit 239 259)
  ;;:create :city :name Detroit :orientation west \
  ;;	:shape :circle :thickness -1 :center [239,259] :radius  5

  (setup-city 'Indianapolis 138 407)
  ;;:create :city :name Indianapolis :orientation southwest \
  ;;	:shape :circle :thickness -1 :center [138,407] :radius  5

  (setup-city 'Lexington 205 500)
  ;;:create :city :name Lexington :orientation west \
  ;;	:shape :circle :thickness -1 :center [205,500] :radius  5

  (setup-city 'Milwaukee 47 234)
  ;;:create :city :name Milwaukee :orientation west \
  ;;	:shape :circle :thickness -1 :center [47,234] :radius  5

  (setup-city 'Montreal 561 23)
  ;;:create :city :name Montreal :orientation east \
  ;;	:shape :circle :thickness -1 :center [561,23] :radius  5

  (setup-city 'New_York_City 614 255)
  ;;:create :city :name New_York :label "New York" :orientation northwest \
  ;;	:shape :circle :thickness -1 :center [614,255] :radius  7

  (setup-city 'Philadelphia 572 315)
  ;;:create :city :name Philadelphia :orientation southeast \
  ;;	:shape :circle :thickness -1 :center [572,315] :radius  5
  (setup-city-alias 'Philadelphia 'Philly)

  (setup-city 'Pittsburgh 375 324)
  ;;:create :city :name Pittsburgh :orientation southeast \
  ;;	:shape :circle :thickness -1 :center [375,324] :radius  5

  (setup-city 'Raleigh 521 542)
  ;;:create :city :name Raleigh :orientation east \
  ;;	:shape :circle :thickness -1 :center [521,542] :radius  5

  (setup-city 'Richmond 506 466)
  ;;:create :city :name Richmond :orientation east \
  ;;	:shape :circle :thickness -1 :center [506,466] :radius  5

  (setup-city 'Scranton 535 284)
  ;;#:create :city :name Scranton :orientation northwest \
  ;;#	:shape :circle :thickness -1 :center [535,284] :radius  5

  (setup-city 'Syracuse 506 173)
  ;;:create :city :name Syracuse :orientation north \
  ;;	:shape :circle :thickness -1 :center [506,173] :radius  5

  (setup-city 'Toledo 235 297)
  ;;:create :city :name Toledo :orientation southwest \
  ;;	:shape :circle :thickness -1 :center [235,297] :radius  5

  (setup-city 'Toronto 371 155)
  ;;:create :city :name Toronto :orientation west \
  ;;	:shape :circle :thickness -1 :center [371,155] :radius  5

  (setup-city 'Washington 503 387)
  ;;:create :city :name Washington :orientation west \
  ;;	:shape :circle :thickness -1 :center [503,387] :radius  5
  (setup-city-alias 'Washington 'D_C)

  ;;#
  ;;:create :track :start Albany :end Burlington :name Albany-Burlington
  (setup-track 'Albany 'Burlington)
  ;;:create :track :start Albany :end Boston :name Albany-Boston
  (setup-track 'Albany 'Boston)
  ;;:create :track :start Albany :end New_York_City :name Albany-New_York
  (setup-track 'Albany 'New_York_City)
  ;;:create :track :start Albany :end Syracuse :name Albany-Syracuse
  (setup-track 'Albany 'Syracuse)
  ;;:create :track :start Atlanta :end Charlotte :name Atlanta-Charlotte
  (setup-track 'Atlanta 'Charlotte)
  ;;:create :track :start Atlanta :end Lexington :name Atlanta-Lexington
  (setup-track 'Atlanta 'Lexington)
  ;;:create :track :start Baltimore :end Washington :name Baltimore-Washington
  (setup-track 'Baltimore 'Washington)
  ;;:create :track :start Baltimore :end Syracuse :name Baltimore-Syracuse
  (setup-track 'Baltimore 'Scranton)
  ;;:create :track :start Baltimore :end Philadelphia :name Baltimore-Philadelphia
  (setup-track 'Baltimore 'Philadelphia)
  ;;:create :track :start Buffalo :end Cleveland :name Buffalo-Cleveland
  (setup-track 'Buffalo 'Cleveland)
  ;;:create :track :start Buffalo :end Toronto :name Buffalo-Toronto
  (setup-track 'Buffalo 'Toronto)
  ;;:create :track :start Buffalo :end Syracuse :name Buffalo-Syracuse
  (setup-track 'Buffalo 'Syracuse)
  ;;:create :track :start Buffalo :end Pittsburgh :name Buffalo-Pittsburgh
  (setup-track 'Buffalo 'Pittsburgh)
  ;;:create :track :start Burlington :end Montreal :name Burlington-Montreal
  (setup-track 'Burlington 'Montreal)
  ;;:create :track :start Boston :end New_York :name Boston-New_York
  (setup-track 'Boston 'New_York_City)
  ;;:create :track :start Charleston :end Cincinnati :name Charleston-Cincinnati
  (setup-track 'Charleston 'Cincinnati)
  ;;:create :track :start Charleston :end Pittsburgh :name Charleston-Pittsburgh
  (setup-track 'Charleston 'Pittsburgh)
  ;;:create :track :start Charleston :end Richmond :name Charleston-Richmond
  (setup-track 'Charleston 'Richmond)
  ;;:create :track :start Charleston :end Charlotte :name Charleston-Charlotte
  (setup-track 'Charleston 'Charlotte)
  ;;:create :track :start Charlotte :end Raleigh :name Charlotte-Raleigh
  (setup-track 'Charlotte 'Raleigh)
  ;;:create :track :start Chicago :end Milwaukee :name Chicago-Milwaukee
  (setup-track 'Chicago 'Milwaukee)
  ;;:create :track :start Chicago :end Indianapolis :name Chicago-Indianapolis
  (setup-track 'Chicago 'Indianapolis)
  ;;:create :track :start Chicago :end Toledo :name Chicago-Toledo
  (setup-track 'Chicago 'Toledo)
  ;;:create :track :start Cincinnati :end Indianapolis :name Cincinnati-Indianapolis
  (setup-track 'Cincinnati 'Indianapolis)
  ;;:create :track :start Cincinnati :end Lexington :name Cincinnati-Lexington
  (setup-track 'Cincinnati 'Lexington)
  ;;:create :track :start Cleveland :end Toledo :name Cleveland-Toledo
  (setup-track 'Cleveland 'Toledo)
  ;;:create :track :start Columbus :end Toledo :name Columbus-Toledo
  (setup-track 'Columbus 'Toledo)
  ;;:create :track :start Columbus :end Indianapolis :name Columbus-Indianapolis
  (setup-track 'Columbus 'Indianapolis)
  ;;:create :track :start Columbus :end Pittsburgh :name Columbus-Pittsburgh
  (setup-track 'Columbus 'Pittsburgh)
  ;;:create :track :start Columbus :end Cincinnati :name Columbus-Cincinnati
  (setup-track 'Columbus 'Cincinnati)
  ;;:create :track :start Detroit :end Toledo :name Detroit-Toledo
  (setup-track 'Detroit 'Toledo)
  ;;:create :track :start Detroit :end Toronto :name Detroit-Toronto
  (setup-track 'Detroit 'Toronto)
  ;;:create :track :start Indianapolis :end Lexington :name Indianapolis-Lexington
  (setup-track 'Indianapolis 'Lexington)
  ;;:create :track :start Montreal :end Toronto :name Montreal-Toronto
  (setup-track 'Montreal 'Toronto)
  ;;:create :track :start New_York :end Pittsburgh :name New_York-Pittsburgh
  (setup-track 'New_York_City 'Scranton)
  ;;:create :track :start New_York :end Philadelphia :name New_York-Philadelphia
  (setup-track 'New_York_City 'Philadelphia)
  (setup-track 'Philadelphia 'Scranton)
  (setup-track 'Pittsburgh 'Scranton)
  ;;:create :track :start Raleigh :end Richmond :name Raleigh-Richmond
  (setup-track 'Raleigh 'Richmond)
  ;;:create :track :start Richmond :end Washington :name Richmond-Washington
  (setup-track 'Richmond 'Washington)
  (setup-track 'Scranton 'Syracuse)

