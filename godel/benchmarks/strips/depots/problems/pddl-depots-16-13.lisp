(define (problem depotprob130) (:domain Depot)
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
	(clear crate14)
	(at pallet2 distributor0)
	(clear crate9)
	(at pallet3 distributor1)
	(clear crate11)
	(at truck0 depot0)
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
	(at crate1 depot0)
	(on crate1 pallet0)
	(at crate2 depot0)
	(on crate2 crate1)
	(at crate3 depot0)
	(on crate3 crate2)
	(at crate4 depot0)
	(on crate4 crate3)
	(at crate5 distributor0)
	(on crate5 pallet2)
	(at crate6 distributor0)
	(on crate6 crate5)
	(at crate7 distributor1)
	(on crate7 crate0)
	(at crate8 depot1)
	(on crate8 pallet1)
	(at crate9 distributor0)
	(on crate9 crate6)
	(at crate10 distributor1)
	(on crate10 crate7)
	(at crate11 distributor1)
	(on crate11 crate10)
	(at crate12 depot0)
	(on crate12 crate4)
	(at crate13 depot0)
	(on crate13 crate12)
	(at crate14 depot1)
	(on crate14 crate8)
	(at crate15 depot0)
	(on crate15 crate13)
)

(:goal (and
		(on crate0 pallet0)
		(on crate1 crate12)
		(on crate2 crate15)
		(on crate3 crate10)
		(on crate4 pallet2)
		(on crate5 crate4)
		(on crate6 pallet1)
		(on crate8 pallet3)
		(on crate9 crate1)
		(on crate10 crate13)
		(on crate11 crate14)
		(on crate12 crate8)
		(on crate13 crate6)
		(on crate14 crate5)
		(on crate15 crate9)
	)
))
