(define (problem depotprob230) (:domain Depot)
(:objects
	depot0 depot1 depot2 - Depot
	distributor0 distributor1 distributor2 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate23)
	(at pallet1 depot1)
	(clear crate22)
	(at pallet2 depot2)
	(clear crate11)
	(at pallet3 distributor0)
	(clear crate16)
	(at pallet4 distributor1)
	(clear crate21)
	(at pallet5 distributor2)
	(clear crate18)
	(at truck0 distributor2)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 depot2)
	(available hoist2)
	(at hoist3 distributor0)
	(available hoist3)
	(at hoist4 distributor1)
	(available hoist4)
	(at hoist5 distributor2)
	(available hoist5)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 depot2)
	(on crate1 pallet2)
	(at crate2 distributor1)
	(on crate2 pallet4)
	(at crate3 distributor0)
	(on crate3 pallet3)
	(at crate4 distributor2)
	(on crate4 pallet5)
	(at crate5 depot1)
	(on crate5 pallet1)
	(at crate6 depot1)
	(on crate6 crate5)
	(at crate7 distributor2)
	(on crate7 crate4)
	(at crate8 depot1)
	(on crate8 crate6)
	(at crate9 distributor0)
	(on crate9 crate3)
	(at crate10 depot0)
	(on crate10 crate0)
	(at crate11 depot2)
	(on crate11 crate1)
	(at crate12 distributor0)
	(on crate12 crate9)
	(at crate13 distributor2)
	(on crate13 crate7)
	(at crate14 depot0)
	(on crate14 crate10)
	(at crate15 distributor0)
	(on crate15 crate12)
	(at crate16 distributor0)
	(on crate16 crate15)
	(at crate17 depot0)
	(on crate17 crate14)
	(at crate18 distributor2)
	(on crate18 crate13)
	(at crate19 distributor1)
	(on crate19 crate2)
	(at crate20 depot0)
	(on crate20 crate17)
	(at crate21 distributor1)
	(on crate21 crate19)
	(at crate22 depot1)
	(on crate22 crate8)
	(at crate23 depot0)
	(on crate23 crate20)
)

(:goal (and
		(on crate0 crate2)
		(on crate1 crate15)
		(on crate2 pallet2)
		(on crate4 crate5)
		(on crate5 crate10)
		(on crate6 crate12)
		(on crate7 crate19)
		(on crate8 crate6)
		(on crate10 crate11)
		(on crate11 pallet3)
		(on crate12 crate4)
		(on crate13 crate18)
		(on crate14 crate13)
		(on crate15 pallet5)
		(on crate17 pallet0)
		(on crate18 crate20)
		(on crate19 pallet1)
		(on crate20 crate17)
		(on crate21 crate0)
		(on crate22 crate14)
		(on crate23 pallet4)
	)
))
