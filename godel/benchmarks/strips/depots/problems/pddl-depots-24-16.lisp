(define (problem depotprob160) (:domain Depot)
(:objects
	depot0 depot1 depot2 - Depot
	distributor0 distributor1 distributor2 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate21)
	(at pallet1 depot1)
	(clear crate22)
	(at pallet2 depot2)
	(clear crate23)
	(at pallet3 distributor0)
	(clear crate15)
	(at pallet4 distributor1)
	(clear crate18)
	(at pallet5 distributor2)
	(clear crate19)
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
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 distributor1)
	(on crate1 pallet4)
	(at crate2 depot1)
	(on crate2 pallet1)
	(at crate3 depot2)
	(on crate3 pallet2)
	(at crate4 depot0)
	(on crate4 crate0)
	(at crate5 depot2)
	(on crate5 crate3)
	(at crate6 distributor1)
	(on crate6 crate1)
	(at crate7 depot0)
	(on crate7 crate4)
	(at crate8 depot0)
	(on crate8 crate7)
	(at crate9 distributor1)
	(on crate9 crate6)
	(at crate10 distributor1)
	(on crate10 crate9)
	(at crate11 depot1)
	(on crate11 crate2)
	(at crate12 depot1)
	(on crate12 crate11)
	(at crate13 distributor2)
	(on crate13 pallet5)
	(at crate14 distributor1)
	(on crate14 crate10)
	(at crate15 distributor0)
	(on crate15 pallet3)
	(at crate16 distributor2)
	(on crate16 crate13)
	(at crate17 distributor2)
	(on crate17 crate16)
	(at crate18 distributor1)
	(on crate18 crate14)
	(at crate19 distributor2)
	(on crate19 crate17)
	(at crate20 depot0)
	(on crate20 crate8)
	(at crate21 depot0)
	(on crate21 crate20)
	(at crate22 depot1)
	(on crate22 crate12)
	(at crate23 depot2)
	(on crate23 crate5)
)

(:goal (and
		(on crate0 pallet1)
		(on crate1 crate4)
		(on crate2 crate15)
		(on crate3 pallet3)
		(on crate4 crate9)
		(on crate6 pallet5)
		(on crate7 crate18)
		(on crate8 crate1)
		(on crate9 crate19)
		(on crate10 crate17)
		(on crate11 pallet2)
		(on crate12 crate21)
		(on crate14 crate3)
		(on crate15 crate10)
		(on crate16 crate23)
		(on crate17 crate7)
		(on crate18 crate14)
		(on crate19 crate6)
		(on crate20 crate11)
		(on crate21 pallet4)
		(on crate22 crate16)
		(on crate23 pallet0)
	)
))