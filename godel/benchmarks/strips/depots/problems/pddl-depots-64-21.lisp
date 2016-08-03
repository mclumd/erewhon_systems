(define (problem depotprob210) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate62)
	(at pallet1 depot1)
	(clear crate53)
	(at pallet2 depot2)
	(clear crate43)
	(at pallet3 depot3)
	(clear crate57)
	(at pallet4 depot4)
	(clear crate38)
	(at pallet5 depot5)
	(clear crate36)
	(at pallet6 depot6)
	(clear crate9)
	(at pallet7 depot7)
	(clear crate48)
	(at pallet8 distributor0)
	(clear crate63)
	(at pallet9 distributor1)
	(clear crate41)
	(at pallet10 distributor2)
	(clear crate31)
	(at pallet11 distributor3)
	(clear crate51)
	(at pallet12 distributor4)
	(clear crate54)
	(at pallet13 distributor5)
	(clear crate58)
	(at pallet14 distributor6)
	(clear crate55)
	(at pallet15 distributor7)
	(clear crate60)
	(at truck0 distributor7)
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
	(at hoist6 depot6)
	(available hoist6)
	(at hoist7 depot7)
	(available hoist7)
	(at hoist8 distributor0)
	(available hoist8)
	(at hoist9 distributor1)
	(available hoist9)
	(at hoist10 distributor2)
	(available hoist10)
	(at hoist11 distributor3)
	(available hoist11)
	(at hoist12 distributor4)
	(available hoist12)
	(at hoist13 distributor5)
	(available hoist13)
	(at hoist14 distributor6)
	(available hoist14)
	(at hoist15 distributor7)
	(available hoist15)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 depot7)
	(on crate1 pallet7)
	(at crate2 distributor5)
	(on crate2 pallet13)
	(at crate3 depot7)
	(on crate3 crate1)
	(at crate4 distributor1)
	(on crate4 pallet9)
	(at crate5 distributor5)
	(on crate5 crate2)
	(at crate6 distributor5)
	(on crate6 crate5)
	(at crate7 distributor1)
	(on crate7 crate4)
	(at crate8 depot7)
	(on crate8 crate3)
	(at crate9 depot6)
	(on crate9 pallet6)
	(at crate10 distributor4)
	(on crate10 pallet12)
	(at crate11 distributor0)
	(on crate11 pallet8)
	(at crate12 distributor2)
	(on crate12 pallet10)
	(at crate13 distributor7)
	(on crate13 pallet15)
	(at crate14 distributor5)
	(on crate14 crate6)
	(at crate15 depot1)
	(on crate15 pallet1)
	(at crate16 distributor2)
	(on crate16 crate12)
	(at crate17 depot3)
	(on crate17 pallet3)
	(at crate18 depot2)
	(on crate18 pallet2)
	(at crate19 distributor5)
	(on crate19 crate14)
	(at crate20 depot1)
	(on crate20 crate15)
	(at crate21 depot5)
	(on crate21 pallet5)
	(at crate22 distributor5)
	(on crate22 crate19)
	(at crate23 distributor6)
	(on crate23 pallet14)
	(at crate24 depot4)
	(on crate24 pallet4)
	(at crate25 depot1)
	(on crate25 crate20)
	(at crate26 distributor5)
	(on crate26 crate22)
	(at crate27 distributor3)
	(on crate27 pallet11)
	(at crate28 distributor7)
	(on crate28 crate13)
	(at crate29 depot7)
	(on crate29 crate8)
	(at crate30 distributor3)
	(on crate30 crate27)
	(at crate31 distributor2)
	(on crate31 crate16)
	(at crate32 depot2)
	(on crate32 crate18)
	(at crate33 distributor5)
	(on crate33 crate26)
	(at crate34 distributor0)
	(on crate34 crate11)
	(at crate35 depot0)
	(on crate35 crate0)
	(at crate36 depot5)
	(on crate36 crate21)
	(at crate37 distributor1)
	(on crate37 crate7)
	(at crate38 depot4)
	(on crate38 crate24)
	(at crate39 distributor0)
	(on crate39 crate34)
	(at crate40 distributor4)
	(on crate40 crate10)
	(at crate41 distributor1)
	(on crate41 crate37)
	(at crate42 depot2)
	(on crate42 crate32)
	(at crate43 depot2)
	(on crate43 crate42)
	(at crate44 distributor7)
	(on crate44 crate28)
	(at crate45 distributor6)
	(on crate45 crate23)
	(at crate46 depot3)
	(on crate46 crate17)
	(at crate47 depot0)
	(on crate47 crate35)
	(at crate48 depot7)
	(on crate48 crate29)
	(at crate49 distributor3)
	(on crate49 crate30)
	(at crate50 distributor0)
	(on crate50 crate39)
	(at crate51 distributor3)
	(on crate51 crate49)
	(at crate52 depot1)
	(on crate52 crate25)
	(at crate53 depot1)
	(on crate53 crate52)
	(at crate54 distributor4)
	(on crate54 crate40)
	(at crate55 distributor6)
	(on crate55 crate45)
	(at crate56 depot3)
	(on crate56 crate46)
	(at crate57 depot3)
	(on crate57 crate56)
	(at crate58 distributor5)
	(on crate58 crate33)
	(at crate59 distributor0)
	(on crate59 crate50)
	(at crate60 distributor7)
	(on crate60 crate44)
	(at crate61 distributor0)
	(on crate61 crate59)
	(at crate62 depot0)
	(on crate62 crate47)
	(at crate63 distributor0)
	(on crate63 crate61)
)

(:goal (and
		(on crate1 crate20)
		(on crate2 crate35)
		(on crate3 crate52)
		(on crate4 crate37)
		(on crate5 crate51)
		(on crate6 crate11)
		(on crate7 pallet1)
		(on crate8 crate17)
		(on crate9 crate44)
		(on crate10 crate55)
		(on crate11 crate49)
		(on crate12 crate27)
		(on crate13 crate31)
		(on crate14 crate59)
		(on crate16 pallet12)
		(on crate17 pallet8)
		(on crate18 crate9)
		(on crate19 crate7)
		(on crate20 crate40)
		(on crate21 crate61)
		(on crate22 pallet7)
		(on crate23 crate33)
		(on crate24 crate57)
		(on crate25 crate3)
		(on crate27 pallet14)
		(on crate28 crate19)
		(on crate29 crate12)
		(on crate30 crate23)
		(on crate31 pallet3)
		(on crate32 crate60)
		(on crate33 pallet5)
		(on crate35 crate54)
		(on crate37 pallet10)
		(on crate38 crate28)
		(on crate39 crate4)
		(on crate40 crate24)
		(on crate42 crate14)
		(on crate44 pallet15)
		(on crate45 crate10)
		(on crate46 crate45)
		(on crate48 crate22)
		(on crate49 crate50)
		(on crate50 crate25)
		(on crate51 pallet13)
		(on crate52 pallet6)
		(on crate53 pallet4)
		(on crate54 pallet11)
		(on crate55 crate8)
		(on crate56 crate18)
		(on crate57 pallet0)
		(on crate59 crate32)
		(on crate60 pallet2)
		(on crate61 pallet9)
	)
))
