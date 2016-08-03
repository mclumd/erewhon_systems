(define (problem depotprob140) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 - Depot
	distributor0 distributor1 distributor2 distributor3 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate15)
	(at pallet1 depot1)
	(clear crate19)
	(at pallet2 depot2)
	(clear crate31)
	(at pallet3 depot3)
	(clear crate30)
	(at pallet4 distributor0)
	(clear crate17)
	(at pallet5 distributor1)
	(clear crate26)
	(at pallet6 distributor2)
	(clear crate9)
	(at pallet7 distributor3)
	(clear crate24)
	(at truck0 distributor1)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 depot2)
	(available hoist2)
	(at hoist3 depot3)
	(available hoist3)
	(at hoist4 distributor0)
	(available hoist4)
	(at hoist5 distributor1)
	(available hoist5)
	(at hoist6 distributor2)
	(available hoist6)
	(at hoist7 distributor3)
	(available hoist7)
	(at crate0 distributor3)
	(on crate0 pallet7)
	(at crate1 depot1)
	(on crate1 pallet1)
	(at crate2 distributor1)
	(on crate2 pallet5)
	(at crate3 depot2)
	(on crate3 pallet2)
	(at crate4 distributor1)
	(on crate4 crate2)
	(at crate5 depot0)
	(on crate5 pallet0)
	(at crate6 depot1)
	(on crate6 crate1)
	(at crate7 depot2)
	(on crate7 crate3)
	(at crate8 depot2)
	(on crate8 crate7)
	(at crate9 distributor2)
	(on crate9 pallet6)
	(at crate10 depot3)
	(on crate10 pallet3)
	(at crate11 depot3)
	(on crate11 crate10)
	(at crate12 depot1)
	(on crate12 crate6)
	(at crate13 distributor1)
	(on crate13 crate4)
	(at crate14 distributor3)
	(on crate14 crate0)
	(at crate15 depot0)
	(on crate15 crate5)
	(at crate16 distributor1)
	(on crate16 crate13)
	(at crate17 distributor0)
	(on crate17 pallet4)
	(at crate18 depot1)
	(on crate18 crate12)
	(at crate19 depot1)
	(on crate19 crate18)
	(at crate20 depot3)
	(on crate20 crate11)
	(at crate21 distributor1)
	(on crate21 crate16)
	(at crate22 distributor3)
	(on crate22 crate14)
	(at crate23 depot2)
	(on crate23 crate8)
	(at crate24 distributor3)
	(on crate24 crate22)
	(at crate25 distributor1)
	(on crate25 crate21)
	(at crate26 distributor1)
	(on crate26 crate25)
	(at crate27 depot3)
	(on crate27 crate20)
	(at crate28 depot3)
	(on crate28 crate27)
	(at crate29 depot2)
	(on crate29 crate23)
	(at crate30 depot3)
	(on crate30 crate28)
	(at crate31 depot2)
	(on crate31 crate29)
)

(:goal (and
		(on crate0 pallet3)
		(on crate1 crate0)
		(on crate2 crate31)
		(on crate3 pallet5)
		(on crate4 pallet0)
		(on crate5 crate18)
		(on crate6 crate5)
		(on crate7 crate30)
		(on crate8 pallet2)
		(on crate9 pallet6)
		(on crate10 pallet7)
		(on crate13 crate29)
		(on crate15 crate7)
		(on crate16 crate13)
		(on crate17 crate6)
		(on crate18 pallet1)
		(on crate19 crate2)
		(on crate20 crate10)
		(on crate23 crate17)
		(on crate25 crate3)
		(on crate26 pallet4)
		(on crate27 crate9)
		(on crate28 crate15)
		(on crate29 crate26)
		(on crate30 crate23)
		(on crate31 crate25)
	)
))
