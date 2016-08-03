(define (problem depotprob120) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate25)
	(at pallet1 depot1)
	(clear crate21)
	(at pallet2 depot2)
	(clear crate43)
	(at pallet3 depot3)
	(clear crate29)
	(at pallet4 depot4)
	(clear crate28)
	(at pallet5 depot5)
	(clear crate30)
	(at pallet6 distributor0)
	(clear crate46)
	(at pallet7 distributor1)
	(clear crate10)
	(at pallet8 distributor2)
	(clear crate44)
	(at pallet9 distributor3)
	(clear crate47)
	(at pallet10 distributor4)
	(clear crate45)
	(at pallet11 distributor5)
	(clear crate41)
	(at truck0 distributor5)
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
	(at crate0 distributor2)
	(on crate0 pallet8)
	(at crate1 depot3)
	(on crate1 pallet3)
	(at crate2 depot2)
	(on crate2 pallet2)
	(at crate3 depot2)
	(on crate3 crate2)
	(at crate4 distributor2)
	(on crate4 crate0)
	(at crate5 depot1)
	(on crate5 pallet1)
	(at crate6 distributor5)
	(on crate6 pallet11)
	(at crate7 depot3)
	(on crate7 crate1)
	(at crate8 depot0)
	(on crate8 pallet0)
	(at crate9 distributor4)
	(on crate9 pallet10)
	(at crate10 distributor1)
	(on crate10 pallet7)
	(at crate11 distributor4)
	(on crate11 crate9)
	(at crate12 depot0)
	(on crate12 crate8)
	(at crate13 distributor4)
	(on crate13 crate11)
	(at crate14 depot4)
	(on crate14 pallet4)
	(at crate15 distributor3)
	(on crate15 pallet9)
	(at crate16 depot1)
	(on crate16 crate5)
	(at crate17 distributor2)
	(on crate17 crate4)
	(at crate18 depot3)
	(on crate18 crate7)
	(at crate19 depot4)
	(on crate19 crate14)
	(at crate20 distributor0)
	(on crate20 pallet6)
	(at crate21 depot1)
	(on crate21 crate16)
	(at crate22 distributor0)
	(on crate22 crate20)
	(at crate23 distributor4)
	(on crate23 crate13)
	(at crate24 distributor0)
	(on crate24 crate22)
	(at crate25 depot0)
	(on crate25 crate12)
	(at crate26 distributor5)
	(on crate26 crate6)
	(at crate27 distributor5)
	(on crate27 crate26)
	(at crate28 depot4)
	(on crate28 crate19)
	(at crate29 depot3)
	(on crate29 crate18)
	(at crate30 depot5)
	(on crate30 pallet5)
	(at crate31 distributor4)
	(on crate31 crate23)
	(at crate32 depot2)
	(on crate32 crate3)
	(at crate33 distributor5)
	(on crate33 crate27)
	(at crate34 distributor0)
	(on crate34 crate24)
	(at crate35 distributor0)
	(on crate35 crate34)
	(at crate36 distributor3)
	(on crate36 crate15)
	(at crate37 distributor0)
	(on crate37 crate35)
	(at crate38 depot2)
	(on crate38 crate32)
	(at crate39 distributor4)
	(on crate39 crate31)
	(at crate40 depot2)
	(on crate40 crate38)
	(at crate41 distributor5)
	(on crate41 crate33)
	(at crate42 distributor3)
	(on crate42 crate36)
	(at crate43 depot2)
	(on crate43 crate40)
	(at crate44 distributor2)
	(on crate44 crate17)
	(at crate45 distributor4)
	(on crate45 crate39)
	(at crate46 distributor0)
	(on crate46 crate37)
	(at crate47 distributor3)
	(on crate47 crate42)
)

(:goal (and
		(on crate0 crate37)
		(on crate1 pallet5)
		(on crate3 crate40)
		(on crate5 pallet11)
		(on crate6 crate26)
		(on crate9 crate32)
		(on crate10 crate46)
		(on crate11 crate23)
		(on crate12 crate9)
		(on crate13 crate16)
		(on crate14 crate3)
		(on crate15 crate14)
		(on crate16 pallet7)
		(on crate17 crate24)
		(on crate18 crate27)
		(on crate19 crate38)
		(on crate20 crate34)
		(on crate21 pallet2)
		(on crate22 crate10)
		(on crate23 crate45)
		(on crate24 crate31)
		(on crate26 crate5)
		(on crate27 crate29)
		(on crate28 pallet4)
		(on crate29 crate28)
		(on crate30 crate35)
		(on crate31 crate0)
		(on crate32 crate21)
		(on crate33 crate6)
		(on crate34 crate36)
		(on crate35 crate39)
		(on crate36 pallet3)
		(on crate37 pallet0)
		(on crate38 crate20)
		(on crate39 pallet10)
		(on crate40 pallet6)
		(on crate41 pallet9)
		(on crate42 crate41)
		(on crate43 crate13)
		(on crate45 pallet1)
		(on crate46 pallet8)
		(on crate47 crate15)
	)
))
