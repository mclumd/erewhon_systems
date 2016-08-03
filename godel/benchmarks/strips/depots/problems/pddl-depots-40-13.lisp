(define (problem depotprob130) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate20)
	(at pallet1 depot1)
	(clear crate32)
	(at pallet2 depot2)
	(clear crate25)
	(at pallet3 depot3)
	(clear crate30)
	(at pallet4 depot4)
	(clear crate37)
	(at pallet5 distributor0)
	(clear crate36)
	(at pallet6 distributor1)
	(clear crate38)
	(at pallet7 distributor2)
	(clear crate34)
	(at pallet8 distributor3)
	(clear crate4)
	(at pallet9 distributor4)
	(clear crate39)
	(at truck0 distributor1)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 depot2)
	(available hoist2)
	(at hoist3 depot3)
	(available hoist3)
	(at hoist4 depot4)
	(available hoist4)
	(at hoist5 distributor0)
	(available hoist5)
	(at hoist6 distributor1)
	(available hoist6)
	(at hoist7 distributor2)
	(available hoist7)
	(at hoist8 distributor3)
	(available hoist8)
	(at hoist9 distributor4)
	(available hoist9)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 distributor1)
	(on crate1 pallet6)
	(at crate2 depot2)
	(on crate2 pallet2)
	(at crate3 depot4)
	(on crate3 pallet4)
	(at crate4 distributor3)
	(on crate4 pallet8)
	(at crate5 depot0)
	(on crate5 crate0)
	(at crate6 distributor1)
	(on crate6 crate1)
	(at crate7 distributor4)
	(on crate7 pallet9)
	(at crate8 distributor4)
	(on crate8 crate7)
	(at crate9 distributor1)
	(on crate9 crate6)
	(at crate10 depot3)
	(on crate10 pallet3)
	(at crate11 depot3)
	(on crate11 crate10)
	(at crate12 depot0)
	(on crate12 crate5)
	(at crate13 distributor1)
	(on crate13 crate9)
	(at crate14 depot3)
	(on crate14 crate11)
	(at crate15 distributor0)
	(on crate15 pallet5)
	(at crate16 distributor4)
	(on crate16 crate8)
	(at crate17 distributor2)
	(on crate17 pallet7)
	(at crate18 distributor2)
	(on crate18 crate17)
	(at crate19 depot4)
	(on crate19 crate3)
	(at crate20 depot0)
	(on crate20 crate12)
	(at crate21 depot1)
	(on crate21 pallet1)
	(at crate22 depot2)
	(on crate22 crate2)
	(at crate23 depot4)
	(on crate23 crate19)
	(at crate24 depot2)
	(on crate24 crate22)
	(at crate25 depot2)
	(on crate25 crate24)
	(at crate26 depot4)
	(on crate26 crate23)
	(at crate27 distributor0)
	(on crate27 crate15)
	(at crate28 depot1)
	(on crate28 crate21)
	(at crate29 depot3)
	(on crate29 crate14)
	(at crate30 depot3)
	(on crate30 crate29)
	(at crate31 distributor4)
	(on crate31 crate16)
	(at crate32 depot1)
	(on crate32 crate28)
	(at crate33 distributor0)
	(on crate33 crate27)
	(at crate34 distributor2)
	(on crate34 crate18)
	(at crate35 depot4)
	(on crate35 crate26)
	(at crate36 distributor0)
	(on crate36 crate33)
	(at crate37 depot4)
	(on crate37 crate35)
	(at crate38 distributor1)
	(on crate38 crate13)
	(at crate39 distributor4)
	(on crate39 crate31)
)

(:goal (and
		(on crate0 crate16)
		(on crate2 pallet1)
		(on crate3 crate21)
		(on crate4 crate11)
		(on crate5 crate34)
		(on crate6 crate39)
		(on crate7 crate10)
		(on crate8 crate18)
		(on crate9 pallet4)
		(on crate10 pallet5)
		(on crate11 crate2)
		(on crate12 pallet6)
		(on crate13 crate8)
		(on crate14 crate17)
		(on crate15 crate29)
		(on crate16 pallet8)
		(on crate17 crate3)
		(on crate18 pallet2)
		(on crate19 crate0)
		(on crate20 crate12)
		(on crate21 crate31)
		(on crate22 pallet7)
		(on crate23 crate32)
		(on crate24 crate38)
		(on crate25 crate4)
		(on crate26 crate20)
		(on crate28 crate33)
		(on crate29 pallet3)
		(on crate30 crate19)
		(on crate31 crate22)
		(on crate32 crate6)
		(on crate33 pallet0)
		(on crate34 crate9)
		(on crate36 crate7)
		(on crate37 pallet9)
		(on crate38 crate23)
		(on crate39 crate37)
	)
))