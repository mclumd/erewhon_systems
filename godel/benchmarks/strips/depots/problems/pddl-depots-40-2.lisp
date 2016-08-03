(define (problem depotprob20) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate34)
	(at pallet1 depot1)
	(clear crate38)
	(at pallet2 depot2)
	(clear crate35)
	(at pallet3 depot3)
	(clear crate37)
	(at pallet4 depot4)
	(clear crate9)
	(at pallet5 distributor0)
	(clear crate26)
	(at pallet6 distributor1)
	(clear crate39)
	(at pallet7 distributor2)
	(clear crate25)
	(at pallet8 distributor3)
	(clear crate8)
	(at pallet9 distributor4)
	(clear crate32)
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
	(at crate1 distributor0)
	(on crate1 pallet5)
	(at crate2 depot2)
	(on crate2 pallet2)
	(at crate3 depot1)
	(on crate3 pallet1)
	(at crate4 depot1)
	(on crate4 crate3)
	(at crate5 distributor4)
	(on crate5 pallet9)
	(at crate6 distributor3)
	(on crate6 pallet8)
	(at crate7 distributor1)
	(on crate7 pallet6)
	(at crate8 distributor3)
	(on crate8 crate6)
	(at crate9 depot4)
	(on crate9 crate0)
	(at crate10 distributor0)
	(on crate10 crate1)
	(at crate11 depot1)
	(on crate11 crate4)
	(at crate12 distributor2)
	(on crate12 pallet7)
	(at crate13 depot0)
	(on crate13 pallet0)
	(at crate14 distributor4)
	(on crate14 crate5)
	(at crate15 depot0)
	(on crate15 crate13)
	(at crate16 depot0)
	(on crate16 crate15)
	(at crate17 depot3)
	(on crate17 pallet3)
	(at crate18 distributor0)
	(on crate18 crate10)
	(at crate19 distributor2)
	(on crate19 crate12)
	(at crate20 depot2)
	(on crate20 crate2)
	(at crate21 depot1)
	(on crate21 crate11)
	(at crate22 depot3)
	(on crate22 crate17)
	(at crate23 distributor0)
	(on crate23 crate18)
	(at crate24 depot3)
	(on crate24 crate22)
	(at crate25 distributor2)
	(on crate25 crate19)
	(at crate26 distributor0)
	(on crate26 crate23)
	(at crate27 depot1)
	(on crate27 crate21)
	(at crate28 depot0)
	(on crate28 crate16)
	(at crate29 depot3)
	(on crate29 crate24)
	(at crate30 depot3)
	(on crate30 crate29)
	(at crate31 depot3)
	(on crate31 crate30)
	(at crate32 distributor4)
	(on crate32 crate14)
	(at crate33 distributor1)
	(on crate33 crate7)
	(at crate34 depot0)
	(on crate34 crate28)
	(at crate35 depot2)
	(on crate35 crate20)
	(at crate36 depot1)
	(on crate36 crate27)
	(at crate37 depot3)
	(on crate37 crate31)
	(at crate38 depot1)
	(on crate38 crate36)
	(at crate39 distributor1)
	(on crate39 crate33)
)

(:goal (and
		(on crate0 pallet5)
		(on crate1 crate25)
		(on crate2 crate11)
		(on crate5 crate2)
		(on crate7 crate22)
		(on crate8 crate34)
		(on crate9 crate38)
		(on crate10 pallet0)
		(on crate11 crate30)
		(on crate12 crate31)
		(on crate13 crate17)
		(on crate14 pallet6)
		(on crate15 pallet4)
		(on crate16 crate14)
		(on crate17 pallet2)
		(on crate18 crate15)
		(on crate19 crate27)
		(on crate20 pallet9)
		(on crate21 pallet8)
		(on crate22 pallet3)
		(on crate23 crate1)
		(on crate24 crate9)
		(on crate25 crate7)
		(on crate26 crate35)
		(on crate27 crate20)
		(on crate28 crate39)
		(on crate29 crate18)
		(on crate30 crate13)
		(on crate31 crate10)
		(on crate32 crate24)
		(on crate34 crate23)
		(on crate35 crate0)
		(on crate36 crate16)
		(on crate37 pallet1)
		(on crate38 pallet7)
		(on crate39 crate21)
	)
))
