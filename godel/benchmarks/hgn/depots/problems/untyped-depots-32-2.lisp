(define (problem depotprob20) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 distributor0 distributor1 distributor2 distributor3 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate24)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate25)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate23)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate30)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 distributor0)
	(clear crate31)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 distributor1)
	(clear crate28)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 distributor2)
	(clear crate29)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor3)
	(clear crate26)
	(truck truck0)
	(at truck0 depot3)
	(hoist hoist0)
	(at hoist0 depot0)
	(available hoist0)
	(hoist hoist1)
	(at hoist1 depot1)
	(available hoist1)
	(hoist hoist2)
	(at hoist2 depot2)
	(available hoist2)
	(hoist hoist3)
	(at hoist3 depot3)
	(available hoist3)
	(hoist hoist4)
	(at hoist4 distributor0)
	(available hoist4)
	(hoist hoist5)
	(at hoist5 distributor1)
	(available hoist5)
	(hoist hoist6)
	(at hoist6 distributor2)
	(available hoist6)
	(hoist hoist7)
	(at hoist7 distributor3)
	(available hoist7)
	(crate crate0)
	(surface crate0)
	(at crate0 depot1)
	(on crate0 pallet1)
	(crate crate1)
	(surface crate1)
	(at crate1 distributor2)
	(on crate1 pallet6)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor3)
	(on crate2 pallet7)
	(crate crate3)
	(surface crate3)
	(at crate3 depot1)
	(on crate3 crate0)
	(crate crate4)
	(surface crate4)
	(at crate4 depot0)
	(on crate4 pallet0)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor0)
	(on crate5 pallet4)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor0)
	(on crate6 crate5)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor0)
	(on crate7 crate6)
	(crate crate8)
	(surface crate8)
	(at crate8 depot3)
	(on crate8 pallet3)
	(crate crate9)
	(surface crate9)
	(at crate9 depot2)
	(on crate9 pallet2)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor1)
	(on crate10 pallet5)
	(crate crate11)
	(surface crate11)
	(at crate11 depot1)
	(on crate11 crate3)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor1)
	(on crate12 crate10)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor1)
	(on crate13 crate12)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor2)
	(on crate14 crate1)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor1)
	(on crate15 crate13)
	(crate crate16)
	(surface crate16)
	(at crate16 depot1)
	(on crate16 crate11)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor1)
	(on crate17 crate15)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor2)
	(on crate18 crate14)
	(crate crate19)
	(surface crate19)
	(at crate19 depot2)
	(on crate19 crate9)
	(crate crate20)
	(surface crate20)
	(at crate20 depot1)
	(on crate20 crate16)
	(crate crate21)
	(surface crate21)
	(at crate21 depot3)
	(on crate21 crate8)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor0)
	(on crate22 crate7)
	(crate crate23)
	(surface crate23)
	(at crate23 depot2)
	(on crate23 crate19)
	(crate crate24)
	(surface crate24)
	(at crate24 depot0)
	(on crate24 crate4)
	(crate crate25)
	(surface crate25)
	(at crate25 depot1)
	(on crate25 crate20)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor3)
	(on crate26 crate2)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor2)
	(on crate27 crate18)
	(crate crate28)
	(surface crate28)
	(at crate28 distributor1)
	(on crate28 crate17)
	(crate crate29)
	(surface crate29)
	(at crate29 distributor2)
	(on crate29 crate27)
	(crate crate30)
	(surface crate30)
	(at crate30 depot3)
	(on crate30 crate21)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor0)
	(on crate31 crate22)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
)

(:goal (and
		(on crate0 pallet0)
		(on crate1 crate3)
		(on crate2 pallet7)
		(on crate3 crate10)
		(on crate4 crate5)
		(on crate5 crate19)
		(on crate6 pallet5)
		(on crate7 crate0)
		(on crate8 pallet4)
		(on crate9 crate13)
		(on crate10 crate30)
		(on crate11 crate7)
		(on crate12 pallet3)
		(on crate13 pallet6)
		(on crate14 crate1)
		(on crate16 crate31)
		(on crate17 crate9)
		(on crate18 pallet1)
		(on crate19 pallet2)
		(on crate20 crate6)
		(on crate21 crate23)
		(on crate22 crate11)
		(on crate23 crate18)
		(on crate24 crate2)
		(on crate25 crate16)
		(on crate30 crate4)
		(on crate31 crate22)
	)
))
