(define (problem depotprob100) (:domain Depot)
(:objects
	depot0 depot1 distributor0 distributor1 truck0 pallet0 pallet1 pallet2 pallet3 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 hoist0 hoist1 hoist2 hoist3 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate12)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate7)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 distributor0)
	(clear pallet2)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 distributor1)
	(clear crate15)
	(truck truck0)
	(at truck0 depot0)
	(hoist hoist0)
	(at hoist0 depot0)
	(available hoist0)
	(hoist hoist1)
	(at hoist1 depot1)
	(available hoist1)
	(hoist hoist2)
	(at hoist2 distributor0)
	(available hoist2)
	(hoist hoist3)
	(at hoist3 distributor1)
	(available hoist3)
	(crate crate0)
	(surface crate0)
	(at crate0 depot0)
	(on crate0 pallet0)
	(crate crate1)
	(surface crate1)
	(at crate1 depot1)
	(on crate1 pallet1)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor1)
	(on crate2 pallet3)
	(crate crate3)
	(surface crate3)
	(at crate3 depot1)
	(on crate3 crate1)
	(crate crate4)
	(surface crate4)
	(at crate4 depot1)
	(on crate4 crate3)
	(crate crate5)
	(surface crate5)
	(at crate5 depot1)
	(on crate5 crate4)
	(crate crate6)
	(surface crate6)
	(at crate6 depot1)
	(on crate6 crate5)
	(crate crate7)
	(surface crate7)
	(at crate7 depot1)
	(on crate7 crate6)
	(crate crate8)
	(surface crate8)
	(at crate8 distributor1)
	(on crate8 crate2)
	(crate crate9)
	(surface crate9)
	(at crate9 depot0)
	(on crate9 crate0)
	(crate crate10)
	(surface crate10)
	(at crate10 depot0)
	(on crate10 crate9)
	(crate crate11)
	(surface crate11)
	(at crate11 depot0)
	(on crate11 crate10)
	(crate crate12)
	(surface crate12)
	(at crate12 depot0)
	(on crate12 crate11)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor1)
	(on crate13 crate8)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor1)
	(on crate14 crate13)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor1)
	(on crate15 crate14)
	(place depot0)
	(place depot1)
	(place distributor0)
	(place distributor1)
)

(:goal (and
		(on crate0 crate11)
		(on crate2 crate8)
		(on crate3 crate12)
		(on crate4 pallet1)
		(on crate5 crate14)
		(on crate6 crate0)
		(on crate7 crate10)
		(on crate8 crate7)
		(on crate9 crate5)
		(on crate10 crate15)
		(on crate11 crate13)
		(on crate12 pallet2)
		(on crate13 pallet0)
		(on crate14 crate3)
		(on crate15 crate4)
	)
))
