(define (problem depotprob180) (:domain Depot)
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
	(clear crate16)
	(at pallet2 depot2)
	(clear crate30)
	(at pallet3 depot3)
	(clear crate19)
	(at pallet4 distributor0)
	(clear crate28)
	(at pallet5 distributor1)
	(clear crate24)
	(at pallet6 distributor2)
	(clear crate29)
	(at pallet7 distributor3)
	(clear crate23)
	(at truck0 depot2)
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
	(at crate1 distributor3)
	(on crate1 pallet7)
	(at crate2 depot1)
	(on crate2 pallet1)
	(at crate3 distributor1)
	(on crate3 pallet5)
	(at crate4 distributor2)
	(on crate4 pallet6)
	(at crate5 depot2)
	(on crate5 pallet2)
	(at crate6 distributor3)
	(on crate6 crate1)
	(at crate7 distributor2)
	(on crate7 crate4)
	(at crate8 depot1)
	(on crate8 crate2)
	(at crate9 distributor3)
	(on crate9 crate6)
	(at crate10 depot3)
	(on crate10 pallet3)
	(at crate11 depot0)
	(on crate11 pallet0)
	(at crate12 depot2)
	(on crate12 crate5)
	(at crate13 depot1)
	(on crate13 crate8)
	(at crate14 depot3)
	(on crate14 crate10)
	(at crate15 distributor3)
	(on crate15 crate9)
	(at crate16 depot1)
	(on crate16 crate13)
	(at crate17 distributor3)
	(on crate17 crate15)
	(at crate18 distributor2)
	(on crate18 crate7)
	(at crate19 depot3)
	(on crate19 crate14)
	(at crate20 distributor1)
	(on crate20 crate3)
	(at crate21 distributor0)
	(on crate21 crate0)
	(at crate22 distributor1)
	(on crate22 crate20)
	(at crate23 distributor3)
	(on crate23 crate17)
	(at crate24 distributor1)
	(on crate24 crate22)
	(at crate25 distributor0)
	(on crate25 crate21)
	(at crate26 distributor2)
	(on crate26 crate18)
	(at crate27 distributor2)
	(on crate27 crate26)
	(at crate28 distributor0)
	(on crate28 crate25)
	(at crate29 distributor2)
	(on crate29 crate27)
	(at crate30 depot2)
	(on crate30 crate12)
	(at crate31 depot0)
	(on crate31 crate11)
)

(:goal (and
		(on crate1 pallet6)
		(on crate2 crate22)
		(on crate3 crate19)
		(on crate4 crate18)
		(on crate6 crate13)
		(on crate7 pallet1)
		(on crate9 crate7)
		(on crate10 pallet3)
		(on crate11 crate17)
		(on crate12 pallet7)
		(on crate13 crate10)
		(on crate14 pallet5)
		(on crate15 crate14)
		(on crate17 crate28)
		(on crate18 crate15)
		(on crate19 crate20)
		(on crate20 pallet0)
		(on crate22 crate12)
		(on crate23 pallet2)
		(on crate24 crate11)
		(on crate25 crate9)
		(on crate26 crate1)
		(on crate27 crate6)
		(on crate28 crate30)
		(on crate29 crate3)
		(on crate30 pallet4)
	)
))
