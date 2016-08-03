(define (problem depotprob170) (:domain Depot)
(:objects
	depot0 depot1 - Depot
	distributor0 distributor1 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 - Crate
	hoist0 hoist1 hoist2 hoist3 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate15)
	(at pallet1 depot1)
	(clear crate12)
	(at pallet2 distributor0)
	(clear crate13)
	(at pallet3 distributor1)
	(clear crate8)
	(at truck0 depot1)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 distributor0)
	(available hoist2)
	(at hoist3 distributor1)
	(available hoist3)
	(at crate0 distributor1)
	(on crate0 pallet3)
	(at crate1 depot1)
	(on crate1 pallet1)
	(at crate2 distributor0)
	(on crate2 pallet2)
	(at crate3 distributor1)
	(on crate3 crate0)
	(at crate4 depot0)
	(on crate4 pallet0)
	(at crate5 distributor1)
	(on crate5 crate3)
	(at crate6 depot0)
	(on crate6 crate4)
	(at crate7 distributor1)
	(on crate7 crate5)
	(at crate8 distributor1)
	(on crate8 crate7)
	(at crate9 depot1)
	(on crate9 crate1)
	(at crate10 depot1)
	(on crate10 crate9)
	(at crate11 depot0)
	(on crate11 crate6)
	(at crate12 depot1)
	(on crate12 crate10)
	(at crate13 distributor0)
	(on crate13 crate2)
	(at crate14 depot0)
	(on crate14 crate11)
	(at crate15 depot0)
	(on crate15 crate14)
)

(:goal (and
		(on crate0 crate4)
		(on crate4 pallet0)
		(on crate5 crate12)
		(on crate7 pallet2)
		(on crate8 crate13)
		(on crate9 crate10)
		(on crate10 pallet1)
		(on crate11 crate8)
		(on crate12 crate7)
		(on crate13 crate9)
		(on crate14 crate15)
		(on crate15 pallet3)
	)
))