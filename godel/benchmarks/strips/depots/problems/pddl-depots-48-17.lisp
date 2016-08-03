(define (problem depotprob170) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate29)
	(at pallet1 depot1)
	(clear crate42)
	(at pallet2 depot2)
	(clear crate44)
	(at pallet3 depot3)
	(clear crate46)
	(at pallet4 depot4)
	(clear crate47)
	(at pallet5 depot5)
	(clear crate40)
	(at pallet6 distributor0)
	(clear crate16)
	(at pallet7 distributor1)
	(clear crate12)
	(at pallet8 distributor2)
	(clear crate43)
	(at pallet9 distributor3)
	(clear crate25)
	(at pallet10 distributor4)
	(clear crate33)
	(at pallet11 distributor5)
	(clear crate39)
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
	(at hoist5 depot5)
	(available hoist5)
	(at hoist6 distributor0)
	(available hoist6)
	(at hoist7 distributor1)
	(available hoist7)
	(at hoist8 distributor2)
	(available hoist8)
	(at hoist9 distributor3)
	(available hoist9)
	(at hoist10 distributor4)
	(available hoist10)
	(at hoist11 distributor5)
	(available hoist11)
	(at crate0 distributor1)
	(on crate0 pallet7)
	(at crate1 depot0)
	(on crate1 pallet0)
	(at crate2 depot5)
	(on crate2 pallet5)
	(at crate3 distributor2)
	(on crate3 pallet8)
	(at crate4 depot2)
	(on crate4 pallet2)
	(at crate5 depot0)
	(on crate5 crate1)
	(at crate6 depot3)
	(on crate6 pallet3)
	(at crate7 depot4)
	(on crate7 pallet4)
	(at crate8 depot5)
	(on crate8 crate2)
	(at crate9 depot2)
	(on crate9 crate4)
	(at crate10 distributor3)
	(on crate10 pallet9)
	(at crate11 distributor1)
	(on crate11 crate0)
	(at crate12 distributor1)
	(on crate12 crate11)
	(at crate13 depot2)
	(on crate13 crate9)
	(at crate14 distributor2)
	(on crate14 crate3)
	(at crate15 depot5)
	(on crate15 crate8)
	(at crate16 distributor0)
	(on crate16 pallet6)
	(at crate17 depot5)
	(on crate17 crate15)
	(at crate18 distributor4)
	(on crate18 pallet10)
	(at crate19 depot1)
	(on crate19 pallet1)
	(at crate20 depot3)
	(on crate20 crate6)
	(at crate21 depot0)
	(on crate21 crate5)
	(at crate22 depot2)
	(on crate22 crate13)
	(at crate23 distributor2)
	(on crate23 crate14)
	(at crate24 distributor5)
	(on crate24 pallet11)
	(at crate25 distributor3)
	(on crate25 crate10)
	(at crate26 depot3)
	(on crate26 crate20)
	(at crate27 depot4)
	(on crate27 crate7)
	(at crate28 depot3)
	(on crate28 crate26)
	(at crate29 depot0)
	(on crate29 crate21)
	(at crate30 depot3)
	(on crate30 crate28)
	(at crate31 depot4)
	(on crate31 crate27)
	(at crate32 distributor5)
	(on crate32 crate24)
	(at crate33 distributor4)
	(on crate33 crate18)
	(at crate34 distributor5)
	(on crate34 crate32)
	(at crate35 distributor5)
	(on crate35 crate34)
	(at crate36 depot2)
	(on crate36 crate22)
	(at crate37 distributor5)
	(on crate37 crate35)
	(at crate38 depot4)
	(on crate38 crate31)
	(at crate39 distributor5)
	(on crate39 crate37)
	(at crate40 depot5)
	(on crate40 crate17)
	(at crate41 depot2)
	(on crate41 crate36)
	(at crate42 depot1)
	(on crate42 crate19)
	(at crate43 distributor2)
	(on crate43 crate23)
	(at crate44 depot2)
	(on crate44 crate41)
	(at crate45 depot4)
	(on crate45 crate38)
	(at crate46 depot3)
	(on crate46 crate30)
	(at crate47 depot4)
	(on crate47 crate45)
)

(:goal (and
		(on crate0 crate20)
		(on crate2 crate10)
		(on crate3 crate32)
		(on crate4 crate36)
		(on crate6 crate9)
		(on crate7 pallet8)
		(on crate8 crate0)
		(on crate9 pallet6)
		(on crate10 crate31)
		(on crate11 pallet0)
		(on crate12 crate38)
		(on crate13 crate6)
		(on crate14 crate47)
		(on crate15 crate11)
		(on crate16 pallet5)
		(on crate17 crate3)
		(on crate18 crate7)
		(on crate19 crate37)
		(on crate20 pallet3)
		(on crate21 pallet11)
		(on crate22 crate35)
		(on crate23 crate14)
		(on crate25 crate21)
		(on crate26 pallet2)
		(on crate28 crate12)
		(on crate29 crate17)
		(on crate30 crate41)
		(on crate31 pallet7)
		(on crate32 crate2)
		(on crate33 crate45)
		(on crate34 crate46)
		(on crate35 crate15)
		(on crate36 crate39)
		(on crate37 crate34)
		(on crate38 pallet9)
		(on crate39 crate16)
		(on crate40 crate26)
		(on crate41 crate23)
		(on crate43 pallet1)
		(on crate45 crate18)
		(on crate46 pallet10)
		(on crate47 pallet4)
	)
))
