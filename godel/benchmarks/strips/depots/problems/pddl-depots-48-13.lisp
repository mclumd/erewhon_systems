(define (problem depotprob130) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate47)
	(at pallet1 depot1)
	(clear crate43)
	(at pallet2 depot2)
	(clear crate46)
	(at pallet3 depot3)
	(clear crate38)
	(at pallet4 depot4)
	(clear crate4)
	(at pallet5 depot5)
	(clear crate16)
	(at pallet6 distributor0)
	(clear crate32)
	(at pallet7 distributor1)
	(clear crate20)
	(at pallet8 distributor2)
	(clear crate35)
	(at pallet9 distributor3)
	(clear crate36)
	(at pallet10 distributor4)
	(clear crate42)
	(at pallet11 distributor5)
	(clear crate45)
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
	(at crate0 depot2)
	(on crate0 pallet2)
	(at crate1 depot5)
	(on crate1 pallet5)
	(at crate2 distributor0)
	(on crate2 pallet6)
	(at crate3 depot2)
	(on crate3 crate0)
	(at crate4 depot4)
	(on crate4 pallet4)
	(at crate5 depot3)
	(on crate5 pallet3)
	(at crate6 distributor5)
	(on crate6 pallet11)
	(at crate7 depot1)
	(on crate7 pallet1)
	(at crate8 distributor0)
	(on crate8 crate2)
	(at crate9 distributor3)
	(on crate9 pallet9)
	(at crate10 depot5)
	(on crate10 crate1)
	(at crate11 distributor0)
	(on crate11 crate8)
	(at crate12 depot5)
	(on crate12 crate10)
	(at crate13 distributor2)
	(on crate13 pallet8)
	(at crate14 distributor5)
	(on crate14 crate6)
	(at crate15 distributor5)
	(on crate15 crate14)
	(at crate16 depot5)
	(on crate16 crate12)
	(at crate17 distributor4)
	(on crate17 pallet10)
	(at crate18 distributor5)
	(on crate18 crate15)
	(at crate19 depot1)
	(on crate19 crate7)
	(at crate20 distributor1)
	(on crate20 pallet7)
	(at crate21 depot2)
	(on crate21 crate3)
	(at crate22 distributor3)
	(on crate22 crate9)
	(at crate23 depot2)
	(on crate23 crate21)
	(at crate24 depot1)
	(on crate24 crate19)
	(at crate25 depot3)
	(on crate25 crate5)
	(at crate26 distributor3)
	(on crate26 crate22)
	(at crate27 depot1)
	(on crate27 crate24)
	(at crate28 distributor0)
	(on crate28 crate11)
	(at crate29 depot0)
	(on crate29 pallet0)
	(at crate30 distributor3)
	(on crate30 crate26)
	(at crate31 distributor3)
	(on crate31 crate30)
	(at crate32 distributor0)
	(on crate32 crate28)
	(at crate33 depot2)
	(on crate33 crate23)
	(at crate34 distributor2)
	(on crate34 crate13)
	(at crate35 distributor2)
	(on crate35 crate34)
	(at crate36 distributor3)
	(on crate36 crate31)
	(at crate37 distributor5)
	(on crate37 crate18)
	(at crate38 depot3)
	(on crate38 crate25)
	(at crate39 distributor4)
	(on crate39 crate17)
	(at crate40 depot1)
	(on crate40 crate27)
	(at crate41 depot0)
	(on crate41 crate29)
	(at crate42 distributor4)
	(on crate42 crate39)
	(at crate43 depot1)
	(on crate43 crate40)
	(at crate44 depot0)
	(on crate44 crate41)
	(at crate45 distributor5)
	(on crate45 crate37)
	(at crate46 depot2)
	(on crate46 crate33)
	(at crate47 depot0)
	(on crate47 crate44)
)

(:goal (and
		(on crate0 crate44)
		(on crate1 crate27)
		(on crate2 crate47)
		(on crate4 pallet7)
		(on crate5 crate8)
		(on crate6 crate43)
		(on crate7 crate16)
		(on crate8 crate37)
		(on crate10 crate33)
		(on crate11 pallet2)
		(on crate12 crate40)
		(on crate13 crate12)
		(on crate14 pallet9)
		(on crate16 crate34)
		(on crate17 pallet11)
		(on crate18 pallet0)
		(on crate19 pallet10)
		(on crate20 crate0)
		(on crate21 crate13)
		(on crate22 crate31)
		(on crate23 crate39)
		(on crate25 crate28)
		(on crate27 crate6)
		(on crate28 crate17)
		(on crate29 crate19)
		(on crate30 crate23)
		(on crate31 crate36)
		(on crate32 pallet1)
		(on crate33 crate18)
		(on crate34 crate11)
		(on crate35 pallet4)
		(on crate36 crate4)
		(on crate37 crate14)
		(on crate38 crate25)
		(on crate39 crate22)
		(on crate40 pallet8)
		(on crate41 pallet6)
		(on crate42 crate35)
		(on crate43 pallet5)
		(on crate44 crate41)
		(on crate45 crate1)
		(on crate46 crate10)
		(on crate47 crate29)
	)
))
