;; Time-stamp: <95/02/13 14:29:43 miller>
(in-package world-kb)

(setq *engine-synonyms* '(plane airplane))
(setq *engine-display-type* :plane)


;;# northeast-air.map: Northeast US with air links
;;#

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


(setup-track 'Albany 'Boston)
(setup-track 'Albany 'New_York)
(setup-track 'Albany 'Syracuse)
(setup-track 'Atlanta 'Charlotte)
(setup-track 'Baltimore 'New_York)
(setup-track 'Baltimore 'Pittsburgh)
(setup-track 'Boston 'Burlington)
(setup-track 'Boston 'Montreal)
(setup-track 'Boston 'New_York)
(setup-track 'Boston 'Philadelphia)
(setup-track 'Buffalo 'New_York)
(setup-track 'Buffalo 'Pittsburgh)
(setup-track 'Buffalo 'Syracuse)
(setup-track 'Burlington 'Montreal)
(setup-track 'Charleston 'Charlotte)
(setup-track 'Charlotte 'Chicago)
(setup-track 'Charlotte 'Lexington)
(setup-track 'Charlotte 'Raleigh)
(setup-track 'Charlotte 'Richmond)
(setup-track 'Charlotte 'Washington)
(setup-track 'Charlotte 'Pittsburgh)
(setup-track 'Chicago 'Cincinnati)
(setup-track 'Chicago 'Detroit)
(setup-track 'Chicago 'Indianapolis)
(setup-track 'Chicago 'Milwaukee)
(setup-track 'Chicago 'New_York)
(setup-track 'Chicago 'Pittsburgh)
(setup-track 'Chicago 'Toledo)
(setup-track 'Cincinnati 'Pittsburgh)
(setup-track 'Cleveland 'Pittsburgh)
(setup-track 'Columbus 'Pittsburgh)
(setup-track 'Detroit 'Toronto)
(setup-track 'Montreal 'Toronto)
(setup-track 'New_York 'Syracuse)
(setup-track 'New_York 'Toronto)
(setup-track 'New_York 'Pittsburgh)
(setup-track 'New_York 'Washington)
(setup-track 'Philadelphia 'Pittsburgh)
(setup-track 'Philadelphia 'Scranton)
(setup-track 'Philadelphia 'Washington)
(setup-track 'Pittsburgh 'Washington)
(setup-track 'Pittsburgh 'Scranton)
(setup-track 'Pittsburgh 'Toronto)

