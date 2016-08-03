(define (problem depotprob230) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate37)
	(at pallet1 depot1)
	(clear crate36)
	(at pallet2 depot2)
	(clear crate32)
	(at pallet3 depot3)
	(clear crate39)
	(at pallet4 depot4)
	(clear crate11)
	(at pallet5 distributor0)
	(clear crate28)
	(at pallet6 distributor1)
	(clear crate34)
	(at pallet7 distributor2)
	(clear crate14)
	(at pallet8 distributor3)
	(clear crate29)
	(at pallet9 distributor4)
	(clear crate25)
	(at truck0 distributor2)
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
	(at crate0 depot2)
	(on crate0 pallet2)
	(at crate1 depot4)
	(on crate1 pallet4)
	(at crate2 depot2)
	(on crate2 crate0)
	(at crate3 depot0)
	(on crate3 pallet0)
	(at crate4 depot0)
	(on crate4 crate3)
	(at crate5 distributor3)
	(on crate5 pallet8)
	(at crate6 depot4)
	(on crate6 crate1)
	(at crate7 depot1)
	(on crate7 pallet1)
	(at crate8 depot0)
	(on crate8 crate4)
	(at crate9 depot1)
	(on crate9 crate7)
	(at crate10 depot1)
	(on crate10 crate9)
	(at crate11 depot4)
	(on crate11 crate6)
	(at crate12 distributor1)
	(on crate12 pallet6)
	(at crate13 distributor1)
	(on crate13 crate12)
	(at crate14 distributor2)
	(on crate14 pallet7)
	(at crate15 distributor4)
	(on crate15 pallet9)
	(at crate16 distributor4)
	(on crate16 crate15)
	(at crate17 depot1)
	(on crate17 crate10)
	(at crate18 distributor4)
	(on crate18 crate16)
	(at crate19 distributor4)
	(on crate19 crate18)
	(at crate20 distributor4)
	(on crate20 crate19)
	(at crate21 depot0)
	(on crate21 crate8)
	(at crate22 distributor0)
	(on crate22 pallet5)
	(at crate23 distributor4)
	(on crate23 crate20)
	(at crate24 distributor3)
	(on crate24 crate5)
	(at crate25 distributor4)
	(on crate25 crate23)
	(at crate26 depot1)
	(on crate26 crate17)
	(at crate27 depot3)
	(on crate27 pallet3)
	(at crate28 distributor0)
	(on crate28 crate22)
	(at crate29 distributor3)
	(on crate29 crate24)
	(at crate30 depot2)
	(on crate30 crate2)
	(at crate31 depot3)
	(on crate31 crate27)
	(at crate32 depot2)
	(on crate32 crate30)
	(at crate33 depot3)
	(on crate33 crate31)
	(at crate34 distributor1)
	(on crate34 crate13)
	(at crate35 depot1)
	(on crate35 crate26)
	(at crate36 depot1)
	(on crate36 crate35)
	(at crate37 depot0)
	(on crate37 crate21)
	(at crate38 depot3)
	(on crate38 crate33)
	(at crate39 depot3)
	(on crate39 crate38)
)

(:goal (and
		(on crate0 crate15)
		(on crate1 crate24)
		(on crate2 crate29)
		(on crate3 crate10)
		(on crate4 crate3)
		(on crate5 crate28)
		(on crate6 crate34)
		(on crate7 pallet1)
		(on crate8 pallet4)
		(on crate10 crate7)
		(on crate11 pallet6)
		(on crate12 crate5)
		(on crate13 crate8)
		(on crate15 crate20)
		(on crate16 crate30)
		(on crate18 pallet2)
		(on crate20 pallet0)
		(on crate21 crate18)
		(on crate22 crate11)
		(on crate23 crate16)
		(on crate24 crate4)
		(on crate26 pallet3)
		(on crate27 crate13)
		(on crate28 pallet7)
		(on crate29 crate26)
		(on crate30 crate12)
		(on crate33 crate37)
		(on crate34 crate33)
		(on crate35 crate1)
		(on crate36 pallet5)
		(on crate37 crate38)
		(on crate38 pallet8)
		(on crate39 crate22)
	)
))