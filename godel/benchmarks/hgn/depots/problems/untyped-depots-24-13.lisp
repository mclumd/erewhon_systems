(define (problem depotprob130) (:domain Depot)
(:objects
	depot0 depot1 depot2 distributor0 distributor1 distributor2 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate20)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate23)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate11)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 distributor0)
	(clear crate21)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 distributor1)
	(clear crate14)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 distributor2)
	(clear crate22)
	(truck truck0)
	(at truck0 depot0)
	(hoist hoist0)
	(at hoist0 depot0)
	(available hoist0)
	(hoist hoist1)
	(at hoist1 depot1)
	(available hoist1)
	(hoist hoist2)
	(at hoist2 depot2)
	(available hoist2)
	(hoist hoist3)
	(at hoist3 distributor0)
	(available hoist3)
	(hoist hoist4)
	(at hoist4 distributor1)
	(available hoist4)
	(hoist hoist5)
	(at hoist5 distributor2)
	(available hoist5)
	(crate crate0)
	(surface crate0)
	(at crate0 depot0)
	(on crate0 pallet0)
	(crate crate1)
	(surface crate1)
	(at crate1 depot2)
	(on crate1 pallet2)
	(crate crate2)
	(surface crate2)
	(at crate2 depot1)
	(on crate2 pallet1)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor0)
	(on crate3 pallet3)
	(crate crate4)
	(surface crate4)
	(at crate4 distributor0)
	(on crate4 crate3)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor2)
	(on crate5 pallet5)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor1)
	(on crate6 pallet4)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor0)
	(on crate7 crate4)
	(crate crate8)
	(surface crate8)
	(at crate8 depot0)
	(on crate8 crate0)
	(crate crate9)
	(surface crate9)
	(at crate9 depot0)
	(on crate9 crate8)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor1)
	(on crate10 crate6)
	(crate crate11)
	(surface crate11)
	(at crate11 depot2)
	(on crate11 crate1)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor2)
	(on crate12 crate5)
	(crate crate13)
	(surface crate13)
	(at crate13 depot1)
	(on crate13 crate2)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor1)
	(on crate14 crate10)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor0)
	(on crate15 crate7)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor0)
	(on crate16 crate15)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor2)
	(on crate17 crate12)
	(crate crate18)
	(surface crate18)
	(at crate18 depot1)
	(on crate18 crate13)
	(crate crate19)
	(surface crate19)
	(at crate19 depot0)
	(on crate19 crate9)
	(crate crate20)
	(surface crate20)
	(at crate20 depot0)
	(on crate20 crate19)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor0)
	(on crate21 crate16)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor2)
	(on crate22 crate17)
	(crate crate23)
	(surface crate23)
	(at crate23 depot1)
	(on crate23 crate18)
	(place depot0)
	(place depot1)
	(place depot2)
	(place distributor0)
	(place distributor1)
	(place distributor2)
)

(:goal (and
		(on crate0 crate16)
		(on crate2 crate10)
		(on crate3 pallet3)
		(on crate4 crate9)
		(on crate5 crate2)
		(on crate7 crate23)
		(on crate8 crate18)
		(on crate9 pallet1)
		(on crate10 pallet5)
		(on crate13 crate19)
		(on crate14 crate0)
		(on crate15 crate7)
		(on crate16 crate17)
		(on crate17 crate20)
		(on crate18 crate4)
		(on crate19 crate15)
		(on crate20 pallet4)
		(on crate21 pallet0)
		(on crate22 crate14)
		(on crate23 pallet2)
	)
))
