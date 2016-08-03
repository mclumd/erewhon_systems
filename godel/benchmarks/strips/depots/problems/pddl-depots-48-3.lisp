(define (problem depotprob30) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate37)
	(at pallet1 depot1)
	(clear crate43)
	(at pallet2 depot2)
	(clear crate41)
	(at pallet3 depot3)
	(clear crate35)
	(at pallet4 depot4)
	(clear crate9)
	(at pallet5 depot5)
	(clear crate45)
	(at pallet6 distributor0)
	(clear crate32)
	(at pallet7 distributor1)
	(clear crate38)
	(at pallet8 distributor2)
	(clear crate47)
	(at pallet9 distributor3)
	(clear crate40)
	(at pallet10 distributor4)
	(clear crate39)
	(at pallet11 distributor5)
	(clear crate46)
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
	(at crate1 distributor4)
	(on crate1 pallet10)
	(at crate2 depot3)
	(on crate2 pallet3)
	(at crate3 distributor0)
	(on crate3 pallet6)
	(at crate4 depot5)
	(on crate4 pallet5)
	(at crate5 depot4)
	(on crate5 pallet4)
	(at crate6 distributor3)
	(on crate6 pallet9)
	(at crate7 distributor3)
	(on crate7 crate6)
	(at crate8 distributor5)
	(on crate8 pallet11)
	(at crate9 depot4)
	(on crate9 crate5)
	(at crate10 depot2)
	(on crate10 pallet2)
	(at crate11 depot3)
	(on crate11 crate2)
	(at crate12 distributor1)
	(on crate12 crate0)
	(at crate13 depot5)
	(on crate13 crate4)
	(at crate14 distributor4)
	(on crate14 crate1)
	(at crate15 depot2)
	(on crate15 crate10)
	(at crate16 distributor0)
	(on crate16 crate3)
	(at crate17 distributor1)
	(on crate17 crate12)
	(at crate18 distributor2)
	(on crate18 pallet8)
	(at crate19 distributor4)
	(on crate19 crate14)
	(at crate20 distributor3)
	(on crate20 crate7)
	(at crate21 depot2)
	(on crate21 crate15)
	(at crate22 distributor5)
	(on crate22 crate8)
	(at crate23 depot2)
	(on crate23 crate21)
	(at crate24 distributor2)
	(on crate24 crate18)
	(at crate25 depot3)
	(on crate25 crate11)
	(at crate26 distributor4)
	(on crate26 crate19)
	(at crate27 depot0)
	(on crate27 pallet0)
	(at crate28 depot5)
	(on crate28 crate13)
	(at crate29 depot3)
	(on crate29 crate25)
	(at crate30 depot2)
	(on crate30 crate23)
	(at crate31 distributor3)
	(on crate31 crate20)
	(at crate32 distributor0)
	(on crate32 crate16)
	(at crate33 distributor2)
	(on crate33 crate24)
	(at crate34 distributor2)
	(on crate34 crate33)
	(at crate35 depot3)
	(on crate35 crate29)
	(at crate36 distributor5)
	(on crate36 crate22)
	(at crate37 depot0)
	(on crate37 crate27)
	(at crate38 distributor1)
	(on crate38 crate17)
	(at crate39 distributor4)
	(on crate39 crate26)
	(at crate40 distributor3)
	(on crate40 crate31)
	(at crate41 depot2)
	(on crate41 crate30)
	(at crate42 distributor2)
	(on crate42 crate34)
	(at crate43 depot1)
	(on crate43 pallet1)
	(at crate44 distributor2)
	(on crate44 crate42)
	(at crate45 depot5)
	(on crate45 crate28)
	(at crate46 distributor5)
	(on crate46 crate36)
	(at crate47 distributor2)
	(on crate47 crate44)
)

(:goal (and
		(on crate0 crate1)
		(on crate1 crate24)
		(on crate2 crate20)
		(on crate3 pallet10)
		(on crate4 crate39)
		(on crate5 crate3)
		(on crate6 pallet3)
		(on crate7 crate38)
		(on crate8 crate29)
		(on crate9 pallet1)
		(on crate10 pallet8)
		(on crate11 crate10)
		(on crate12 crate23)
		(on crate13 crate34)
		(on crate14 crate8)
		(on crate15 crate35)
		(on crate16 crate47)
		(on crate18 pallet2)
		(on crate19 pallet7)
		(on crate20 crate14)
		(on crate21 pallet9)
		(on crate23 crate15)
		(on crate24 crate6)
		(on crate25 pallet0)
		(on crate26 crate5)
		(on crate27 crate0)
		(on crate28 crate43)
		(on crate29 crate21)
		(on crate30 crate28)
		(on crate33 crate46)
		(on crate34 crate45)
		(on crate35 pallet5)
		(on crate36 crate27)
		(on crate38 crate19)
		(on crate39 crate13)
		(on crate42 pallet11)
		(on crate43 pallet4)
		(on crate44 crate26)
		(on crate45 pallet6)
		(on crate46 crate25)
		(on crate47 crate9)
	)
))
