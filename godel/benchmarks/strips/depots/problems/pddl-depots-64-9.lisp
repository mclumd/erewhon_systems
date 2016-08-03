(define (problem depotprob90) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate37)
	(at pallet1 depot1)
	(clear crate45)
	(at pallet2 depot2)
	(clear crate51)
	(at pallet3 depot3)
	(clear crate60)
	(at pallet4 depot4)
	(clear crate62)
	(at pallet5 depot5)
	(clear crate61)
	(at pallet6 depot6)
	(clear crate55)
	(at pallet7 depot7)
	(clear crate47)
	(at pallet8 distributor0)
	(clear crate46)
	(at pallet9 distributor1)
	(clear crate63)
	(at pallet10 distributor2)
	(clear crate50)
	(at pallet11 distributor3)
	(clear crate53)
	(at pallet12 distributor4)
	(clear crate41)
	(at pallet13 distributor5)
	(clear crate52)
	(at pallet14 distributor6)
	(clear crate57)
	(at pallet15 distributor7)
	(clear crate56)
	(at truck0 depot5)
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
	(at crate2 depot5)
	(on crate2 pallet5)
	(at crate3 distributor6)
	(on crate3 pallet14)
	(at crate4 distributor2)
	(on crate4 pallet10)
	(at crate5 distributor7)
	(on crate5 pallet15)
	(at crate6 depot2)
	(on crate6 pallet2)
	(at crate7 depot3)
	(on crate7 pallet3)
	(at crate8 depot2)
	(on crate8 crate6)
	(at crate9 distributor3)
	(on crate9 pallet11)
	(at crate10 distributor2)
	(on crate10 crate4)
	(at crate11 distributor0)
	(on crate11 pallet8)
	(at crate12 depot1)
	(on crate12 pallet1)
	(at crate13 distributor3)
	(on crate13 crate9)
	(at crate14 distributor7)
	(on crate14 crate5)
	(at crate15 depot7)
	(on crate15 crate1)
	(at crate16 distributor7)
	(on crate16 crate14)
	(at crate17 depot4)
	(on crate17 pallet4)
	(at crate18 distributor3)
	(on crate18 crate13)
	(at crate19 depot4)
	(on crate19 crate17)
	(at crate20 depot4)
	(on crate20 crate19)
	(at crate21 depot3)
	(on crate21 crate7)
	(at crate22 depot0)
	(on crate22 crate0)
	(at crate23 distributor4)
	(on crate23 pallet12)
	(at crate24 distributor0)
	(on crate24 crate11)
	(at crate25 distributor7)
	(on crate25 crate16)
	(at crate26 depot6)
	(on crate26 pallet6)
	(at crate27 depot6)
	(on crate27 crate26)
	(at crate28 distributor7)
	(on crate28 crate25)
	(at crate29 distributor7)
	(on crate29 crate28)
	(at crate30 distributor2)
	(on crate30 crate10)
	(at crate31 distributor6)
	(on crate31 crate3)
	(at crate32 depot5)
	(on crate32 crate2)
	(at crate33 distributor6)
	(on crate33 crate31)
	(at crate34 depot5)
	(on crate34 crate32)
	(at crate35 depot6)
	(on crate35 crate27)
	(at crate36 distributor0)
	(on crate36 crate24)
	(at crate37 depot0)
	(on crate37 crate22)
	(at crate38 distributor7)
	(on crate38 crate29)
	(at crate39 distributor2)
	(on crate39 crate30)
	(at crate40 depot4)
	(on crate40 crate20)
	(at crate41 distributor4)
	(on crate41 crate23)
	(at crate42 depot1)
	(on crate42 crate12)
	(at crate43 depot2)
	(on crate43 crate8)
	(at crate44 depot3)
	(on crate44 crate21)
	(at crate45 depot1)
	(on crate45 crate42)
	(at crate46 distributor0)
	(on crate46 crate36)
	(at crate47 depot7)
	(on crate47 crate15)
	(at crate48 depot2)
	(on crate48 crate43)
	(at crate49 distributor6)
	(on crate49 crate33)
	(at crate50 distributor2)
	(on crate50 crate39)
	(at crate51 depot2)
	(on crate51 crate48)
	(at crate52 distributor5)
	(on crate52 pallet13)
	(at crate53 distributor3)
	(on crate53 crate18)
	(at crate54 distributor7)
	(on crate54 crate38)
	(at crate55 depot6)
	(on crate55 crate35)
	(at crate56 distributor7)
	(on crate56 crate54)
	(at crate57 distributor6)
	(on crate57 crate49)
	(at crate58 depot4)
	(on crate58 crate40)
	(at crate59 depot3)
	(on crate59 crate44)
	(at crate60 depot3)
	(on crate60 crate59)
	(at crate61 depot5)
	(on crate61 crate34)
	(at crate62 depot4)
	(on crate62 crate58)
	(at crate63 distributor1)
	(on crate63 pallet9)
)

(:goal (and
		(on crate0 crate2)
		(on crate1 crate21)
		(on crate2 crate50)
		(on crate3 pallet3)
		(on crate4 pallet10)
		(on crate5 crate41)
		(on crate6 crate14)
		(on crate7 pallet1)
		(on crate8 crate0)
		(on crate9 crate22)
		(on crate11 crate3)
		(on crate13 pallet2)
		(on crate14 pallet7)
		(on crate15 pallet8)
		(on crate16 crate8)
		(on crate17 crate39)
		(on crate19 crate53)
		(on crate20 crate61)
		(on crate21 crate29)
		(on crate22 crate13)
		(on crate23 pallet13)
		(on crate24 crate62)
		(on crate25 pallet9)
		(on crate26 crate59)
		(on crate27 pallet4)
		(on crate28 crate7)
		(on crate29 crate36)
		(on crate30 pallet15)
		(on crate31 crate1)
		(on crate32 crate54)
		(on crate33 crate51)
		(on crate36 crate27)
		(on crate39 pallet12)
		(on crate40 pallet0)
		(on crate41 crate40)
		(on crate42 pallet14)
		(on crate43 crate55)
		(on crate44 crate17)
		(on crate45 crate26)
		(on crate46 crate43)
		(on crate48 crate15)
		(on crate50 pallet6)
		(on crate51 crate45)
		(on crate52 crate25)
		(on crate53 crate23)
		(on crate54 crate48)
		(on crate55 crate58)
		(on crate56 crate19)
		(on crate57 crate20)
		(on crate58 crate24)
		(on crate59 pallet11)
		(on crate60 pallet5)
		(on crate61 crate30)
		(on crate62 crate11)
		(on crate63 crate28)
	)
))