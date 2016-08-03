(define (problem depotprob110) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate5)
	(at pallet1 depot1)
	(clear crate33)
	(at pallet2 depot2)
	(clear crate32)
	(at pallet3 depot3)
	(clear crate34)
	(at pallet4 depot4)
	(clear crate37)
	(at pallet5 distributor0)
	(clear crate29)
	(at pallet6 distributor1)
	(clear crate30)
	(at pallet7 distributor2)
	(clear crate39)
	(at pallet8 distributor3)
	(clear crate38)
	(at pallet9 distributor4)
	(clear crate35)
	(at truck0 distributor4)
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
	(at crate1 depot2)
	(on crate1 pallet2)
	(at crate2 distributor2)
	(on crate2 pallet7)
	(at crate3 distributor2)
	(on crate3 crate2)
	(at crate4 distributor0)
	(on crate4 pallet5)
	(at crate5 depot0)
	(on crate5 pallet0)
	(at crate6 distributor4)
	(on crate6 pallet9)
	(at crate7 depot4)
	(on crate7 crate0)
	(at crate8 distributor4)
	(on crate8 crate6)
	(at crate9 depot1)
	(on crate9 pallet1)
	(at crate10 depot1)
	(on crate10 crate9)
	(at crate11 distributor0)
	(on crate11 crate4)
	(at crate12 depot2)
	(on crate12 crate1)
	(at crate13 depot3)
	(on crate13 pallet3)
	(at crate14 distributor1)
	(on crate14 pallet6)
	(at crate15 distributor2)
	(on crate15 crate3)
	(at crate16 depot3)
	(on crate16 crate13)
	(at crate17 depot3)
	(on crate17 crate16)
	(at crate18 distributor0)
	(on crate18 crate11)
	(at crate19 depot2)
	(on crate19 crate12)
	(at crate20 depot1)
	(on crate20 crate10)
	(at crate21 distributor2)
	(on crate21 crate15)
	(at crate22 distributor0)
	(on crate22 crate18)
	(at crate23 depot3)
	(on crate23 crate17)
	(at crate24 depot1)
	(on crate24 crate20)
	(at crate25 depot3)
	(on crate25 crate23)
	(at crate26 depot1)
	(on crate26 crate24)
	(at crate27 distributor2)
	(on crate27 crate21)
	(at crate28 depot1)
	(on crate28 crate26)
	(at crate29 distributor0)
	(on crate29 crate22)
	(at crate30 distributor1)
	(on crate30 crate14)
	(at crate31 distributor3)
	(on crate31 pallet8)
	(at crate32 depot2)
	(on crate32 crate19)
	(at crate33 depot1)
	(on crate33 crate28)
	(at crate34 depot3)
	(on crate34 crate25)
	(at crate35 distributor4)
	(on crate35 crate8)
	(at crate36 distributor2)
	(on crate36 crate27)
	(at crate37 depot4)
	(on crate37 crate7)
	(at crate38 distributor3)
	(on crate38 crate31)
	(at crate39 distributor2)
	(on crate39 crate36)
)

(:goal (and
		(on crate0 pallet8)
		(on crate1 pallet4)
		(on crate2 crate35)
		(on crate3 crate1)
		(on crate4 crate11)
		(on crate5 pallet3)
		(on crate6 pallet5)
		(on crate8 crate32)
		(on crate9 pallet2)
		(on crate10 crate27)
		(on crate11 pallet6)
		(on crate12 crate4)
		(on crate13 crate29)
		(on crate15 crate10)
		(on crate16 crate31)
		(on crate17 crate16)
		(on crate19 crate9)
		(on crate20 pallet0)
		(on crate21 crate24)
		(on crate22 crate17)
		(on crate23 crate8)
		(on crate24 crate3)
		(on crate25 crate20)
		(on crate27 crate37)
		(on crate28 pallet9)
		(on crate29 crate39)
		(on crate31 crate5)
		(on crate32 crate28)
		(on crate34 crate23)
		(on crate35 pallet1)
		(on crate37 pallet7)
		(on crate38 crate21)
		(on crate39 crate0)
	)
))
