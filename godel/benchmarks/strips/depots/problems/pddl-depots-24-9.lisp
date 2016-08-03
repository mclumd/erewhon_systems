(define (problem depotprob90) (:domain Depot)
(:objects
	depot0 depot1 depot2 - Depot
	distributor0 distributor1 distributor2 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate20)
	(at pallet1 depot1)
	(clear crate22)
	(at pallet2 depot2)
	(clear crate8)
	(at pallet3 distributor0)
	(clear crate23)
	(at pallet4 distributor1)
	(clear crate21)
	(at pallet5 distributor2)
	(clear crate16)
	(at truck0 depot2)
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
	(at crate1 depot0)
	(on crate1 crate0)
	(at crate2 depot0)
	(on crate2 crate1)
	(at crate3 distributor2)
	(on crate3 pallet5)
	(at crate4 depot1)
	(on crate4 pallet1)
	(at crate5 distributor1)
	(on crate5 pallet4)
	(at crate6 depot1)
	(on crate6 crate4)
	(at crate7 distributor2)
	(on crate7 crate3)
	(at crate8 depot2)
	(on crate8 pallet2)
	(at crate9 distributor2)
	(on crate9 crate7)
	(at crate10 distributor2)
	(on crate10 crate9)
	(at crate11 distributor1)
	(on crate11 crate5)
	(at crate12 distributor0)
	(on crate12 pallet3)
	(at crate13 distributor2)
	(on crate13 crate10)
	(at crate14 depot1)
	(on crate14 crate6)
	(at crate15 depot1)
	(on crate15 crate14)
	(at crate16 distributor2)
	(on crate16 crate13)
	(at crate17 distributor0)
	(on crate17 crate12)
	(at crate18 depot1)
	(on crate18 crate15)
	(at crate19 depot0)
	(on crate19 crate2)
	(at crate20 depot0)
	(on crate20 crate19)
	(at crate21 distributor1)
	(on crate21 crate11)
	(at crate22 depot1)
	(on crate22 crate18)
	(at crate23 distributor0)
	(on crate23 crate17)
)

(:goal (and
		(on crate0 crate9)
		(on crate1 crate20)
		(on crate2 pallet3)
		(on crate3 crate8)
		(on crate4 crate16)
		(on crate5 pallet0)
		(on crate6 crate21)
		(on crate7 crate3)
		(on crate8 pallet4)
		(on crate9 crate19)
		(on crate10 pallet2)
		(on crate11 crate12)
		(on crate12 crate23)
		(on crate14 crate2)
		(on crate15 pallet1)
		(on crate16 crate14)
		(on crate19 crate5)
		(on crate20 pallet5)
		(on crate21 crate22)
		(on crate22 crate11)
		(on crate23 crate15)
	)
))