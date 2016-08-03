(define (problem depotprob120) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 - Depot
	distributor0 distributor1 distributor2 distributor3 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate17)
	(at pallet1 depot1)
	(clear crate29)
	(at pallet2 depot2)
	(clear crate30)
	(at pallet3 depot3)
	(clear crate16)
	(at pallet4 distributor0)
	(clear crate27)
	(at pallet5 distributor1)
	(clear crate31)
	(at pallet6 distributor2)
	(clear crate25)
	(at pallet7 distributor3)
	(clear crate28)
	(at truck0 distributor0)
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
	(at crate0 depot2)
	(on crate0 pallet2)
	(at crate1 depot2)
	(on crate1 crate0)
	(at crate2 distributor1)
	(on crate2 pallet5)
	(at crate3 depot0)
	(on crate3 pallet0)
	(at crate4 depot0)
	(on crate4 crate3)
	(at crate5 depot2)
	(on crate5 crate1)
	(at crate6 distributor1)
	(on crate6 crate2)
	(at crate7 depot0)
	(on crate7 crate4)
	(at crate8 distributor1)
	(on crate8 crate6)
	(at crate9 depot2)
	(on crate9 crate5)
	(at crate10 distributor0)
	(on crate10 pallet4)
	(at crate11 distributor3)
	(on crate11 pallet7)
	(at crate12 depot2)
	(on crate12 crate9)
	(at crate13 distributor2)
	(on crate13 pallet6)
	(at crate14 distributor1)
	(on crate14 crate8)
	(at crate15 distributor1)
	(on crate15 crate14)
	(at crate16 depot3)
	(on crate16 pallet3)
	(at crate17 depot0)
	(on crate17 crate7)
	(at crate18 distributor1)
	(on crate18 crate15)
	(at crate19 distributor0)
	(on crate19 crate10)
	(at crate20 depot1)
	(on crate20 pallet1)
	(at crate21 distributor3)
	(on crate21 crate11)
	(at crate22 distributor2)
	(on crate22 crate13)
	(at crate23 depot1)
	(on crate23 crate20)
	(at crate24 depot1)
	(on crate24 crate23)
	(at crate25 distributor2)
	(on crate25 crate22)
	(at crate26 distributor3)
	(on crate26 crate21)
	(at crate27 distributor0)
	(on crate27 crate19)
	(at crate28 distributor3)
	(on crate28 crate26)
	(at crate29 depot1)
	(on crate29 crate24)
	(at crate30 depot2)
	(on crate30 crate12)
	(at crate31 distributor1)
	(on crate31 crate18)
)

(:goal (and
		(on crate0 crate18)
		(on crate1 crate16)
		(on crate2 pallet5)
		(on crate3 crate11)
		(on crate5 crate0)
		(on crate6 crate1)
		(on crate8 crate10)
		(on crate9 crate17)
		(on crate10 crate14)
		(on crate11 crate23)
		(on crate14 pallet2)
		(on crate15 crate3)
		(on crate16 pallet3)
		(on crate17 crate6)
		(on crate18 pallet6)
		(on crate19 pallet1)
		(on crate20 pallet0)
		(on crate23 crate25)
		(on crate24 crate20)
		(on crate25 pallet7)
		(on crate26 crate27)
		(on crate27 crate5)
		(on crate29 crate9)
		(on crate30 crate29)
		(on crate31 crate26)
	)
))
