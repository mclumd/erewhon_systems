(define (problem depotprob190) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 - Depot
	distributor0 distributor1 distributor2 distributor3 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate22)
	(at pallet1 depot1)
	(clear crate27)
	(at pallet2 depot2)
	(clear crate14)
	(at pallet3 depot3)
	(clear crate18)
	(at pallet4 distributor0)
	(clear crate29)
	(at pallet5 distributor1)
	(clear crate23)
	(at pallet6 distributor2)
	(clear crate30)
	(at pallet7 distributor3)
	(clear crate31)
	(at truck0 distributor3)
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
	(at crate0 depot3)
	(on crate0 pallet3)
	(at crate1 depot1)
	(on crate1 pallet1)
	(at crate2 distributor3)
	(on crate2 pallet7)
	(at crate3 depot0)
	(on crate3 pallet0)
	(at crate4 depot3)
	(on crate4 crate0)
	(at crate5 depot1)
	(on crate5 crate1)
	(at crate6 distributor3)
	(on crate6 crate2)
	(at crate7 distributor2)
	(on crate7 pallet6)
	(at crate8 distributor2)
	(on crate8 crate7)
	(at crate9 distributor2)
	(on crate9 crate8)
	(at crate10 depot2)
	(on crate10 pallet2)
	(at crate11 distributor3)
	(on crate11 crate6)
	(at crate12 depot1)
	(on crate12 crate5)
	(at crate13 distributor1)
	(on crate13 pallet5)
	(at crate14 depot2)
	(on crate14 crate10)
	(at crate15 depot1)
	(on crate15 crate12)
	(at crate16 depot3)
	(on crate16 crate4)
	(at crate17 distributor3)
	(on crate17 crate11)
	(at crate18 depot3)
	(on crate18 crate16)
	(at crate19 depot1)
	(on crate19 crate15)
	(at crate20 depot1)
	(on crate20 crate19)
	(at crate21 distributor1)
	(on crate21 crate13)
	(at crate22 depot0)
	(on crate22 crate3)
	(at crate23 distributor1)
	(on crate23 crate21)
	(at crate24 distributor3)
	(on crate24 crate17)
	(at crate25 distributor2)
	(on crate25 crate9)
	(at crate26 distributor0)
	(on crate26 pallet4)
	(at crate27 depot1)
	(on crate27 crate20)
	(at crate28 distributor3)
	(on crate28 crate24)
	(at crate29 distributor0)
	(on crate29 crate26)
	(at crate30 distributor2)
	(on crate30 crate25)
	(at crate31 distributor3)
	(on crate31 crate28)
)

(:goal (and
		(on crate0 pallet7)
		(on crate1 crate27)
		(on crate2 crate9)
		(on crate3 crate2)
		(on crate4 crate25)
		(on crate5 crate21)
		(on crate6 crate28)
		(on crate7 pallet5)
		(on crate8 crate26)
		(on crate9 pallet1)
		(on crate10 crate7)
		(on crate12 crate13)
		(on crate13 crate3)
		(on crate14 crate23)
		(on crate15 crate10)
		(on crate16 crate24)
		(on crate17 crate18)
		(on crate18 pallet6)
		(on crate19 crate8)
		(on crate20 crate30)
		(on crate21 crate17)
		(on crate23 crate1)
		(on crate24 pallet3)
		(on crate25 pallet2)
		(on crate26 crate12)
		(on crate27 pallet4)
		(on crate28 crate14)
		(on crate30 pallet0)
		(on crate31 crate15)
	)
))