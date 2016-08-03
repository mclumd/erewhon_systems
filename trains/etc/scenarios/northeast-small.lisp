;; Time-stamp: <96/10/24 16:43:05 ferguson>
(in-package world-kb)

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

  (setup-city 'New_York 614 255)
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
;; from to distance time (in hours)
  (setup-track 'Albany 'Burlington 140 5)
  ;;:create :track :start Albany :end Boston :name Albany-Boston
  (setup-track 'Albany 'Boston 199 7.5)
  ;;:create :track :start Albany :end New_York :name Albany-New_York
  (setup-track 'Albany 'New_York 141 3.62) ; 3:37
  ;;:create :track :start Albany :end Syracuse :name Albany-Syracuse
  (setup-track 'Albany 'Syracuse 144 3.95) ; 3:57
  ;;:create :track :start Atlanta :end Charlotte :name Atlanta-Charlotte
  (setup-track 'Atlanta 'Charlotte 257 6.92) ; 6:55
  ;;:create :track :start Atlanta :end Lexington :name Atlanta-Lexington
  (setup-track 'Atlanta 'Lexington 400 11) ; made up
  ;;:create :track :start Baltimore :end Washington :name Baltimore-Washington
  (setup-track 'Baltimore 'Washington 41 1.1) ;1:06
  ;;:create :track :start Baltimore :end Syracuse :name Baltimore-Syracuse
  (setup-track 'Baltimore 'Scranton 142 5.25) ; made up
  ;;:create :track :start Baltimore :end Philadelphia :name Baltimore-Philadelphia
  (setup-track 'Baltimore 'Philadelphia 94 2.2) ; 2:12
  ;;:create :track :start Buffalo :end Cleveland :name Buffalo-Cleveland
  (setup-track 'Buffalo 'Cleveland 187 4.47) ; 4:28
  ;;:create :track :start Buffalo :end Toronto :name Buffalo-Toronto
  (setup-track 'Buffalo 'Toronto 90 6.12) ; 6:07
  ;;:create :track :start Buffalo :end Syracuse :name Buffalo-Syracuse
  (setup-track 'Buffalo 'Syracuse 152 3.52) ; 3:31
  ;;:create :track :start Buffalo :end Pittsburgh :name Buffalo-Pittsburgh
  (setup-track 'Buffalo 'Pittsburgh 249 7.28) ; 7:17 (was phl pittsburgh, but philadelphia is different)
  ;;:create :track :start Burlington :end Montreal :name Burlington-Montreal
  (setup-track 'Burlington 'Montreal 100 3.75) ; made up, but from albany->burlington (consistant)
  ;;:create :track :start Boston :end New_York :name Boston-New_York
  (setup-track 'Boston 'New_York 231 6.63) ; 6:38
  ;;:create :track :start Charleston :end Cincinnati :name Charleston-Cincinnati
  (setup-track 'Charleston 'Cincinnati 210 7)
  ;;:create :track :start Charleston :end Pittsburgh :name Charleston-Pittsburgh
  (setup-track 'Charleston 'Pittsburgh 213 7.1) ; jfa
  ;;:create :track :start Charleston :end Richmond :name Charleston-Richmond
  (setup-track 'Charleston 'Richmond 306 8.75) ; jfa
  ;;:create :track :start Charleston :end Charlotte :name Charleston-Charlotte
  (setup-track 'Charleston 'Charlotte 400 12) ; jfa
  ;;:create :track :start Charlotte :end Raleigh :name Charlotte-Raleigh
  (setup-track 'Charlotte 'Raleigh 172 5.3) ; 5:18
  ;;:create :track :start Chicago :end Milwaukee :name Chicago-Milwaukee
  (setup-track 'Chicago 'Milwaukee 90 2.3) ; made up distance
  ;;:create :track :start Chicago :end Indianapolis :name Chicago-Indianapolis
  (setup-track 'Chicago 'Indianapolis 195 7.18) ; 7:11
  ;;:create :track :start Chicago :end Toledo :name Chicago-Toledo
  (setup-track 'Chicago 'Toledo 234 6.35) ; 6:21
  ;;:create :track :start Cincinnati :end Indianapolis :name Cincinnati-Indianapolis
  (setup-track 'Cincinnati 'Indianapolis 132 5.25) ; 5:15
  ;;:create :track :start Cincinnati :end Lexington :name Cincinnati-Lexington
  (setup-track 'Cincinnati 'Lexington 80 2) ; jfa
  ;;:create :track :start Cleveland :end Toledo :name Cleveland-Toledo
  (setup-track 'Cleveland 'Toledo 107 3.22) ; 3:13
  ;;:create :track :start Columbus :end Toledo :name Columbus-Toledo
  (setup-track 'Columbus 'Toledo 133 3.75) ; jfa
  ;;:create :track :start Columbus :end Indianapolis :name Columbus-Indianapolis
  (setup-track 'Columbus 'Indianapolis 171 5.5) ; jfa
  ;;:create :track :start Columbus :end Pittsburgh :name Columbus-Pittsburgh
  (setup-track 'Columbus 'Pittsburgh 182 6.5) ; made up
  ;;:create :track :start Columbus :end Cincinnati :name Columbus-Cincinnati
  (setup-track 'Columbus 'Cincinnati 120 4) ; made up
  ;;:create :track :start Detroit :end Toledo :name Detroit-Toledo
  (setup-track 'Detroit 'Toledo 58 2.25)
  ;;:create :track :start Detroit :end Toronto :name Detroit-Toronto
  (setup-track 'Detroit 'Toronto 240 6) ; jfa
  ;;:create :track :start Indianapolis :end Lexington :name Indianapolis-Lexington
  (setup-track 'Indianapolis 'Lexington 200 4.5) ; made up
  ;;:create :track :start Montreal :end Toronto :name Montreal-Toronto
  (setup-track 'Montreal 'Toronto 323 7.28) ; 7:17
  ;;:create :track :start New_York :end Pittsburgh :name New_York-Pittsburgh
  (setup-track 'New_York 'Scranton 151 3.75) ; jfa
  ;;:create :track :start New_York :end Philadelphia :name New_York-Philadelphia
  (setup-track 'New_York 'Philadelphia 91 2.52) ; 2:31
  (setup-track 'Philadelphia 'Scranton 104 3.56) ; made up
  (setup-track 'Pittsburgh 'Scranton 300 9) ; made up
  ;;:create :track :start Raleigh :end Richmond :name Raleigh-Richmond
  (setup-track 'Raleigh 'Richmond 196 5.56) ; 5:33
  ;;:create :track :start Richmond :end Washington :name Richmond-Washington
  (setup-track 'Richmond 'Washington 109 3)
  (setup-track 'Scranton 'Syracuse 160 4.75) ; made up

