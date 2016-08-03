(define (problem depotprob10) (:domain Depot)
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
	(clear crate15)
	(at pallet2 depot2)
	(clear crate16)
	(at pallet3 distributor0)
	(clear crate23)
	(at pallet4 distributor1)
	(clear crate21)
	(at pallet5 distributor2)
	(clear crate12)
	(at truck0 depot1)
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
	(at crate0 distributor2)
	(on crate0 pallet5)
	(at crate1 distributor1)
	(on crate1 pallet4)
	(at crate2 distributor0)
	(on crate2 pallet3)
	(at crate3 distributor0)
	(on crate3 crate2)
	(at crate4 distributor1)
	(on crate4 crate1)
	(at crate5 depot2)
	(on crate5 pallet2)
	(at crate6 depot0)
	(on crate6 pallet0)
	(at crate7 distributor0)
	(on crate7 crate3)
	(at crate8 depot2)
	(on crate8 crate5)
	(at crate9 distributor1)
	(on crate9 crate4)
	(at crate10 distributor1)
	(on crate10 crate9)
	(at crate11 depot1)
	(on crate11 pallet1)
	(at crate12 distributor2)
	(on crate12 crate0)
	(at crate13 depot1)
	(on crate13 crate11)
	(at crate14 depot1)
	(on crate14 crate13)
	(at crate15 depot1)
	(on crate15 crate14)
	(at crate16 depot2)
	(on crate16 crate8)
	(at crate17 distributor1)
	(on crate17 crate10)
	(at crate18 distributor1)
	(on crate18 crate17)
	(at crate19 distributor1)
	(on crate19 crate18)
	(at crate20 depot0)
	(on crate20 crate6)
	(at crate21 distributor1)
	(on crate21 crate19)
	(at crate22 distributor0)
	(on crate22 crate7)
	(at crate23 distributor0)
	(on crate23 crate22)
)

(:goal (and
		(on crate1 crate7)
		(on crate2 crate13)
		(on crate3 crate12)
		(on crate4 crate3)
		(on crate5 crate21)
		(on crate7 pallet1)
		(on crate8 pallet3)
		(on crate10 pallet4)
		(on crate12 pallet0)
		(on crate13 crate19)
		(on crate14 crate1)
		(on crate15 crate22)
		(on crate16 pallet5)
		(on crate17 crate15)
		(on crate18 crate2)
		(on crate19 crate20)
		(on crate20 crate16)
		(on crate21 crate14)
		(on crate22 pallet2)
		(on crate23 crate4)
	)
))
