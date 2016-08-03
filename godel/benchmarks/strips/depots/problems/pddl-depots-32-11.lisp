(define (problem depotprob110) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 - Depot
	distributor0 distributor1 distributor2 distributor3 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate31)
	(at pallet1 depot1)
	(clear crate30)
	(at pallet2 depot2)
	(clear crate22)
	(at pallet3 depot3)
	(clear crate28)
	(at pallet4 distributor0)
	(clear crate25)
	(at pallet5 distributor1)
	(clear crate23)
	(at pallet6 distributor2)
	(clear crate24)
	(at pallet7 distributor3)
	(clear crate29)
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
	(at crate0 distributor0)
	(on crate0 pallet4)
	(at crate1 distributor2)
	(on crate1 pallet6)
	(at crate2 depot1)
	(on crate2 pallet1)
	(at crate3 distributor0)
	(on crate3 crate0)
	(at crate4 distributor3)
	(on crate4 pallet7)
	(at crate5 distributor2)
	(on crate5 crate1)
	(at crate6 distributor0)
	(on crate6 crate3)
	(at crate7 distributor1)
	(on crate7 pallet5)
	(at crate8 depot2)
	(on crate8 pallet2)
	(at crate9 depot3)
	(on crate9 pallet3)
	(at crate10 depot1)
	(on crate10 crate2)
	(at crate11 depot0)
	(on crate11 pallet0)
	(at crate12 depot1)
	(on crate12 crate10)
	(at crate13 depot3)
	(on crate13 crate9)
	(at crate14 distributor0)
	(on crate14 crate6)
	(at crate15 distributor3)
	(on crate15 crate4)
	(at crate16 depot3)
	(on crate16 crate13)
	(at crate17 depot2)
	(on crate17 crate8)
	(at crate18 distributor0)
	(on crate18 crate14)
	(at crate19 distributor2)
	(on crate19 crate5)
	(at crate20 depot1)
	(on crate20 crate12)
	(at crate21 depot3)
	(on crate21 crate16)
	(at crate22 depot2)
	(on crate22 crate17)
	(at crate23 distributor1)
	(on crate23 crate7)
	(at crate24 distributor2)
	(on crate24 crate19)
	(at crate25 distributor0)
	(on crate25 crate18)
	(at crate26 depot0)
	(on crate26 crate11)
	(at crate27 distributor3)
	(on crate27 crate15)
	(at crate28 depot3)
	(on crate28 crate21)
	(at crate29 distributor3)
	(on crate29 crate27)
	(at crate30 depot1)
	(on crate30 crate20)
	(at crate31 depot0)
	(on crate31 crate26)
)

(:goal (and
		(on crate0 crate21)
		(on crate1 crate20)
		(on crate2 crate27)
		(on crate3 crate4)
		(on crate4 crate13)
		(on crate6 crate15)
		(on crate7 crate26)
		(on crate8 crate11)
		(on crate9 crate23)
		(on crate10 crate1)
		(on crate11 crate12)
		(on crate12 crate24)
		(on crate13 pallet2)
		(on crate14 crate30)
		(on crate15 crate17)
		(on crate16 crate3)
		(on crate17 pallet1)
		(on crate18 pallet4)
		(on crate19 crate2)
		(on crate20 crate18)
		(on crate21 pallet3)
		(on crate23 crate8)
		(on crate24 pallet0)
		(on crate25 crate29)
		(on crate26 crate16)
		(on crate27 crate9)
		(on crate28 pallet6)
		(on crate29 crate14)
		(on crate30 pallet5)
		(on crate31 crate0)
	)
))