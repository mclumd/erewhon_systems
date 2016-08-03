(define (problem depotprob150) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate39)
	(at pallet1 depot1)
	(clear crate32)
	(at pallet2 depot2)
	(clear crate33)
	(at pallet3 depot3)
	(clear crate27)
	(at pallet4 depot4)
	(clear crate36)
	(at pallet5 distributor0)
	(clear crate19)
	(at pallet6 distributor1)
	(clear crate37)
	(at pallet7 distributor2)
	(clear crate29)
	(at pallet8 distributor3)
	(clear crate38)
	(at pallet9 distributor4)
	(clear crate35)
	(at truck0 distributor3)
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
	(at crate0 depot1)
	(on crate0 pallet1)
	(at crate1 distributor0)
	(on crate1 pallet5)
	(at crate2 depot4)
	(on crate2 pallet4)
	(at crate3 depot0)
	(on crate3 pallet0)
	(at crate4 distributor3)
	(on crate4 pallet8)
	(at crate5 depot1)
	(on crate5 crate0)
	(at crate6 depot3)
	(on crate6 pallet3)
	(at crate7 depot1)
	(on crate7 crate5)
	(at crate8 distributor3)
	(on crate8 crate4)
	(at crate9 depot1)
	(on crate9 crate7)
	(at crate10 distributor4)
	(on crate10 pallet9)
	(at crate11 distributor0)
	(on crate11 crate1)
	(at crate12 distributor1)
	(on crate12 pallet6)
	(at crate13 depot1)
	(on crate13 crate9)
	(at crate14 depot4)
	(on crate14 crate2)
	(at crate15 depot4)
	(on crate15 crate14)
	(at crate16 depot4)
	(on crate16 crate15)
	(at crate17 depot0)
	(on crate17 crate3)
	(at crate18 distributor4)
	(on crate18 crate10)
	(at crate19 distributor0)
	(on crate19 crate11)
	(at crate20 depot4)
	(on crate20 crate16)
	(at crate21 distributor3)
	(on crate21 crate8)
	(at crate22 distributor3)
	(on crate22 crate21)
	(at crate23 distributor3)
	(on crate23 crate22)
	(at crate24 depot3)
	(on crate24 crate6)
	(at crate25 depot1)
	(on crate25 crate13)
	(at crate26 depot4)
	(on crate26 crate20)
	(at crate27 depot3)
	(on crate27 crate24)
	(at crate28 depot2)
	(on crate28 pallet2)
	(at crate29 distributor2)
	(on crate29 pallet7)
	(at crate30 depot0)
	(on crate30 crate17)
	(at crate31 depot2)
	(on crate31 crate28)
	(at crate32 depot1)
	(on crate32 crate25)
	(at crate33 depot2)
	(on crate33 crate31)
	(at crate34 depot4)
	(on crate34 crate26)
	(at crate35 distributor4)
	(on crate35 crate18)
	(at crate36 depot4)
	(on crate36 crate34)
	(at crate37 distributor1)
	(on crate37 crate12)
	(at crate38 distributor3)
	(on crate38 crate23)
	(at crate39 depot0)
	(on crate39 crate30)
)

(:goal (and
		(on crate0 crate31)
		(on crate1 crate12)
		(on crate2 crate32)
		(on crate3 pallet8)
		(on crate4 pallet4)
		(on crate5 pallet5)
		(on crate6 pallet3)
		(on crate7 pallet6)
		(on crate8 crate7)
		(on crate9 crate29)
		(on crate10 crate24)
		(on crate11 crate21)
		(on crate12 crate37)
		(on crate13 crate2)
		(on crate14 crate19)
		(on crate15 crate14)
		(on crate16 crate36)
		(on crate17 crate3)
		(on crate18 crate22)
		(on crate19 crate1)
		(on crate21 crate33)
		(on crate22 crate10)
		(on crate23 crate27)
		(on crate24 crate16)
		(on crate25 crate38)
		(on crate26 crate6)
		(on crate27 crate8)
		(on crate28 pallet0)
		(on crate29 crate0)
		(on crate31 crate4)
		(on crate32 crate23)
		(on crate33 crate34)
		(on crate34 crate39)
		(on crate35 crate25)
		(on crate36 pallet2)
		(on crate37 pallet1)
		(on crate38 crate17)
		(on crate39 pallet7)
	)
))