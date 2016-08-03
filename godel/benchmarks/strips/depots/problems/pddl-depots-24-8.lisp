(define (problem depotprob80) (:domain Depot)
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
	(clear crate20)
	(at pallet2 depot2)
	(clear crate10)
	(at pallet3 distributor0)
	(clear crate21)
	(at pallet4 distributor1)
	(clear crate18)
	(at pallet5 distributor2)
	(clear crate22)
	(at truck0 distributor0)
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
	(at crate4 depot2)
	(on crate4 pallet2)
	(at crate5 distributor0)
	(on crate5 crate3)
	(at crate6 depot2)
	(on crate6 crate4)
	(at crate7 depot1)
	(on crate7 pallet1)
	(at crate8 depot2)
	(on crate8 crate6)
	(at crate9 distributor2)
	(on crate9 crate0)
	(at crate10 depot2)
	(on crate10 crate8)
	(at crate11 depot1)
	(on crate11 crate7)
	(at crate12 depot0)
	(on crate12 pallet0)
	(at crate13 distributor0)
	(on crate13 crate5)
	(at crate14 distributor1)
	(on crate14 crate1)
	(at crate15 distributor1)
	(on crate15 crate14)
	(at crate16 distributor1)
	(on crate16 crate15)
	(at crate17 distributor1)
	(on crate17 crate16)
	(at crate18 distributor1)
	(on crate18 crate17)
	(at crate19 distributor0)
	(on crate19 crate13)
	(at crate20 depot1)
	(on crate20 crate11)
	(at crate21 distributor0)
	(on crate21 crate19)
	(at crate22 distributor2)
	(on crate22 crate9)
	(at crate23 depot0)
	(on crate23 crate12)
)

(:goal (and
		(on crate0 crate18)
		(on crate1 crate2)
		(on crate2 crate16)
		(on crate3 crate8)
		(on crate4 crate12)
		(on crate5 pallet5)
		(on crate6 pallet1)
		(on crate7 crate3)
		(on crate8 crate20)
		(on crate10 crate21)
		(on crate11 crate10)
		(on crate12 crate6)
		(on crate13 pallet3)
		(on crate15 crate19)
		(on crate16 crate17)
		(on crate17 crate22)
		(on crate18 pallet4)
		(on crate19 crate0)
		(on crate20 crate5)
		(on crate21 crate4)
		(on crate22 pallet0)
		(on crate23 pallet2)
	)
))
