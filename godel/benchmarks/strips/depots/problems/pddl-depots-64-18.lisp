(define (problem depotprob180) (:domain Depot)
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
	(clear crate47)
	(at pallet2 depot2)
	(clear crate46)
	(at pallet3 depot3)
	(clear crate63)
	(at pallet4 depot4)
	(clear crate42)
	(at pallet5 depot5)
	(clear crate61)
	(at pallet6 depot6)
	(clear crate51)
	(at pallet7 depot7)
	(clear crate57)
	(at pallet8 distributor0)
	(clear crate50)
	(at pallet9 distributor1)
	(clear crate49)
	(at pallet10 distributor2)
	(clear crate60)
	(at pallet11 distributor3)
	(clear crate56)
	(at pallet12 distributor4)
	(clear crate2)
	(at pallet13 distributor5)
	(clear crate53)
	(at pallet14 distributor6)
	(clear crate58)
	(at pallet15 distributor7)
	(clear crate59)
	(at truck0 depot2)
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
	(at crate2 distributor4)
	(on crate2 pallet12)
	(at crate3 depot1)
	(on crate3 pallet1)
	(at crate4 depot5)
	(on crate4 pallet5)
	(at crate5 depot2)
	(on crate5 pallet2)
	(at crate6 distributor3)
	(on crate6 pallet11)
	(at crate7 depot0)
	(on crate7 crate0)
	(at crate8 depot4)
	(on crate8 pallet4)
	(at crate9 distributor6)
	(on crate9 pallet14)
	(at crate10 depot7)
	(on crate10 crate1)
	(at crate11 depot4)
	(on crate11 crate8)
	(at crate12 depot6)
	(on crate12 pallet6)
	(at crate13 depot5)
	(on crate13 crate4)
	(at crate14 distributor5)
	(on crate14 pallet13)
	(at crate15 depot4)
	(on crate15 crate11)
	(at crate16 depot0)
	(on crate16 crate7)
	(at crate17 depot5)
	(on crate17 crate13)
	(at crate18 distributor7)
	(on crate18 pallet15)
	(at crate19 distributor2)
	(on crate19 pallet10)
	(at crate20 distributor7)
	(on crate20 crate18)
	(at crate21 distributor3)
	(on crate21 crate6)
	(at crate22 distributor1)
	(on crate22 pallet9)
	(at crate23 distributor2)
	(on crate23 crate19)
	(at crate24 depot0)
	(on crate24 crate16)
	(at crate25 depot5)
	(on crate25 crate17)
	(at crate26 depot0)
	(on crate26 crate24)
	(at crate27 distributor0)
	(on crate27 pallet8)
	(at crate28 distributor1)
	(on crate28 crate22)
	(at crate29 depot2)
	(on crate29 crate5)
	(at crate30 distributor1)
	(on crate30 crate28)
	(at crate31 depot5)
	(on crate31 crate25)
	(at crate32 depot4)
	(on crate32 crate15)
	(at crate33 depot6)
	(on crate33 crate12)
	(at crate34 depot0)
	(on crate34 crate26)
	(at crate35 depot7)
	(on crate35 crate10)
	(at crate36 distributor5)
	(on crate36 crate14)
	(at crate37 distributor3)
	(on crate37 crate21)
	(at crate38 distributor7)
	(on crate38 crate20)
	(at crate39 depot4)
	(on crate39 crate32)
	(at crate40 distributor7)
	(on crate40 crate38)
	(at crate41 distributor0)
	(on crate41 crate27)
	(at crate42 depot4)
	(on crate42 crate39)
	(at crate43 depot7)
	(on crate43 crate35)
	(at crate44 distributor6)
	(on crate44 crate9)
	(at crate45 depot5)
	(on crate45 crate31)
	(at crate46 depot2)
	(on crate46 crate29)
	(at crate47 depot1)
	(on crate47 crate3)
	(at crate48 depot5)
	(on crate48 crate45)
	(at crate49 distributor1)
	(on crate49 crate30)
	(at crate50 distributor0)
	(on crate50 crate41)
	(at crate51 depot6)
	(on crate51 crate33)
	(at crate52 depot5)
	(on crate52 crate48)
	(at crate53 distributor5)
	(on crate53 crate36)
	(at crate54 depot7)
	(on crate54 crate43)
	(at crate55 depot5)
	(on crate55 crate52)
	(at crate56 distributor3)
	(on crate56 crate37)
	(at crate57 depot7)
	(on crate57 crate54)
	(at crate58 distributor6)
	(on crate58 crate44)
	(at crate59 distributor7)
	(on crate59 crate40)
	(at crate60 distributor2)
	(on crate60 crate23)
	(at crate61 depot5)
	(on crate61 crate55)
	(at crate62 depot0)
	(on crate62 crate34)
	(at crate63 depot3)
	(on crate63 pallet3)
)

(:goal (and
		(on crate3 crate9)
		(on crate4 crate38)
		(on crate5 crate31)
		(on crate6 crate40)
		(on crate7 crate15)
		(on crate8 crate55)
		(on crate9 crate34)
		(on crate10 crate26)
		(on crate11 crate63)
		(on crate12 crate46)
		(on crate13 crate56)
		(on crate14 crate27)
		(on crate15 crate58)
		(on crate16 crate37)
		(on crate17 pallet2)
		(on crate18 pallet4)
		(on crate19 crate59)
		(on crate20 crate17)
		(on crate21 pallet15)
		(on crate22 crate51)
		(on crate25 crate6)
		(on crate26 crate32)
		(on crate27 crate48)
		(on crate28 crate29)
		(on crate29 crate13)
		(on crate30 crate52)
		(on crate31 pallet14)
		(on crate32 pallet6)
		(on crate33 crate57)
		(on crate34 pallet3)
		(on crate36 pallet12)
		(on crate37 pallet5)
		(on crate38 pallet10)
		(on crate40 crate3)
		(on crate41 pallet13)
		(on crate43 crate61)
		(on crate44 crate18)
		(on crate45 pallet9)
		(on crate46 crate45)
		(on crate47 pallet7)
		(on crate48 crate5)
		(on crate49 crate25)
		(on crate50 pallet8)
		(on crate51 pallet11)
		(on crate52 crate47)
		(on crate54 crate19)
		(on crate55 crate43)
		(on crate56 crate20)
		(on crate57 crate22)
		(on crate58 crate4)
		(on crate59 crate41)
		(on crate60 pallet1)
		(on crate61 crate62)
		(on crate62 crate21)
		(on crate63 pallet0)
	)
))