(define (problem depotprob250) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate38)
	(at pallet1 depot1)
	(clear crate28)
	(at pallet2 depot2)
	(clear crate20)
	(at pallet3 depot3)
	(clear crate32)
	(at pallet4 depot4)
	(clear crate39)
	(at pallet5 distributor0)
	(clear crate35)
	(at pallet6 distributor1)
	(clear crate37)
	(at pallet7 distributor2)
	(clear crate26)
	(at pallet8 distributor3)
	(clear crate33)
	(at pallet9 distributor4)
	(clear crate36)
	(at truck0 depot0)
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
	(at crate0 depot4)
	(on crate0 pallet4)
	(at crate1 distributor2)
	(on crate1 pallet7)
	(at crate2 depot4)
	(on crate2 crate0)
	(at crate3 depot3)
	(on crate3 pallet3)
	(at crate4 depot3)
	(on crate4 crate3)
	(at crate5 depot4)
	(on crate5 crate2)
	(at crate6 depot1)
	(on crate6 pallet1)
	(at crate7 distributor1)
	(on crate7 pallet6)
	(at crate8 distributor1)
	(on crate8 crate7)
	(at crate9 depot3)
	(on crate9 crate4)
	(at crate10 distributor2)
	(on crate10 crate1)
	(at crate11 depot0)
	(on crate11 pallet0)
	(at crate12 distributor0)
	(on crate12 pallet5)
	(at crate13 depot1)
	(on crate13 crate6)
	(at crate14 distributor1)
	(on crate14 crate8)
	(at crate15 distributor4)
	(on crate15 pallet9)
	(at crate16 distributor2)
	(on crate16 crate10)
	(at crate17 distributor3)
	(on crate17 pallet8)
	(at crate18 depot4)
	(on crate18 crate5)
	(at crate19 depot3)
	(on crate19 crate9)
	(at crate20 depot2)
	(on crate20 pallet2)
	(at crate21 depot4)
	(on crate21 crate18)
	(at crate22 depot4)
	(on crate22 crate21)
	(at crate23 distributor1)
	(on crate23 crate14)
	(at crate24 depot4)
	(on crate24 crate22)
	(at crate25 depot3)
	(on crate25 crate19)
	(at crate26 distributor2)
	(on crate26 crate16)
	(at crate27 distributor3)
	(on crate27 crate17)
	(at crate28 depot1)
	(on crate28 crate13)
	(at crate29 distributor3)
	(on crate29 crate27)
	(at crate30 distributor4)
	(on crate30 crate15)
	(at crate31 distributor4)
	(on crate31 crate30)
	(at crate32 depot3)
	(on crate32 crate25)
	(at crate33 distributor3)
	(on crate33 crate29)
	(at crate34 distributor4)
	(on crate34 crate31)
	(at crate35 distributor0)
	(on crate35 crate12)
	(at crate36 distributor4)
	(on crate36 crate34)
	(at crate37 distributor1)
	(on crate37 crate23)
	(at crate38 depot0)
	(on crate38 crate11)
	(at crate39 depot4)
	(on crate39 crate24)
)

(:goal (and
		(on crate0 crate18)
		(on crate1 crate33)
		(on crate2 crate23)
		(on crate3 crate7)
		(on crate4 crate39)
		(on crate5 pallet1)
		(on crate6 crate13)
		(on crate7 crate15)
		(on crate8 crate25)
		(on crate9 pallet5)
		(on crate11 pallet0)
		(on crate12 crate1)
		(on crate13 pallet9)
		(on crate14 crate35)
		(on crate15 crate31)
		(on crate16 crate32)
		(on crate18 crate6)
		(on crate19 pallet3)
		(on crate20 crate11)
		(on crate21 pallet4)
		(on crate22 pallet7)
		(on crate23 crate4)
		(on crate24 crate16)
		(on crate25 pallet2)
		(on crate27 crate24)
		(on crate28 pallet8)
		(on crate30 crate3)
		(on crate31 pallet6)
		(on crate32 crate28)
		(on crate33 crate20)
		(on crate34 crate21)
		(on crate35 crate8)
		(on crate36 crate5)
		(on crate39 crate36)
	)
))
