(define (problem depotprob70) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate63)
	(at pallet1 depot1)
	(clear crate51)
	(at pallet2 depot2)
	(clear crate33)
	(at pallet3 depot3)
	(clear crate41)
	(at pallet4 depot4)
	(clear crate20)
	(at pallet5 depot5)
	(clear crate55)
	(at pallet6 depot6)
	(clear crate60)
	(at pallet7 depot7)
	(clear crate57)
	(at pallet8 distributor0)
	(clear crate61)
	(at pallet9 distributor1)
	(clear crate54)
	(at pallet10 distributor2)
	(clear crate59)
	(at pallet11 distributor3)
	(clear crate49)
	(at pallet12 distributor4)
	(clear crate47)
	(at pallet13 distributor5)
	(clear crate56)
	(at pallet14 distributor6)
	(clear crate62)
	(at pallet15 distributor7)
	(clear crate45)
	(at truck0 distributor6)
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
	(at crate0 depot6)
	(on crate0 pallet6)
	(at crate1 distributor0)
	(on crate1 pallet8)
	(at crate2 distributor7)
	(on crate2 pallet15)
	(at crate3 depot7)
	(on crate3 pallet7)
	(at crate4 depot5)
	(on crate4 pallet5)
	(at crate5 depot2)
	(on crate5 pallet2)
	(at crate6 distributor2)
	(on crate6 pallet10)
	(at crate7 distributor3)
	(on crate7 pallet11)
	(at crate8 depot1)
	(on crate8 pallet1)
	(at crate9 distributor2)
	(on crate9 crate6)
	(at crate10 distributor3)
	(on crate10 crate7)
	(at crate11 distributor5)
	(on crate11 pallet13)
	(at crate12 depot4)
	(on crate12 pallet4)
	(at crate13 distributor0)
	(on crate13 crate1)
	(at crate14 depot3)
	(on crate14 pallet3)
	(at crate15 depot2)
	(on crate15 crate5)
	(at crate16 distributor3)
	(on crate16 crate10)
	(at crate17 distributor3)
	(on crate17 crate16)
	(at crate18 depot4)
	(on crate18 crate12)
	(at crate19 depot4)
	(on crate19 crate18)
	(at crate20 depot4)
	(on crate20 crate19)
	(at crate21 distributor1)
	(on crate21 pallet9)
	(at crate22 distributor2)
	(on crate22 crate9)
	(at crate23 distributor1)
	(on crate23 crate21)
	(at crate24 depot7)
	(on crate24 crate3)
	(at crate25 depot3)
	(on crate25 crate14)
	(at crate26 depot3)
	(on crate26 crate25)
	(at crate27 distributor6)
	(on crate27 pallet14)
	(at crate28 distributor0)
	(on crate28 crate13)
	(at crate29 distributor5)
	(on crate29 crate11)
	(at crate30 distributor3)
	(on crate30 crate17)
	(at crate31 depot5)
	(on crate31 crate4)
	(at crate32 distributor3)
	(on crate32 crate30)
	(at crate33 depot2)
	(on crate33 crate15)
	(at crate34 depot3)
	(on crate34 crate26)
	(at crate35 distributor3)
	(on crate35 crate32)
	(at crate36 distributor6)
	(on crate36 crate27)
	(at crate37 depot6)
	(on crate37 crate0)
	(at crate38 distributor1)
	(on crate38 crate23)
	(at crate39 depot5)
	(on crate39 crate31)
	(at crate40 depot5)
	(on crate40 crate39)
	(at crate41 depot3)
	(on crate41 crate34)
	(at crate42 distributor2)
	(on crate42 crate22)
	(at crate43 depot0)
	(on crate43 pallet0)
	(at crate44 distributor1)
	(on crate44 crate38)
	(at crate45 distributor7)
	(on crate45 crate2)
	(at crate46 distributor6)
	(on crate46 crate36)
	(at crate47 distributor4)
	(on crate47 pallet12)
	(at crate48 depot5)
	(on crate48 crate40)
	(at crate49 distributor3)
	(on crate49 crate35)
	(at crate50 depot5)
	(on crate50 crate48)
	(at crate51 depot1)
	(on crate51 crate8)
	(at crate52 distributor2)
	(on crate52 crate42)
	(at crate53 distributor5)
	(on crate53 crate29)
	(at crate54 distributor1)
	(on crate54 crate44)
	(at crate55 depot5)
	(on crate55 crate50)
	(at crate56 distributor5)
	(on crate56 crate53)
	(at crate57 depot7)
	(on crate57 crate24)
	(at crate58 distributor2)
	(on crate58 crate52)
	(at crate59 distributor2)
	(on crate59 crate58)
	(at crate60 depot6)
	(on crate60 crate37)
	(at crate61 distributor0)
	(on crate61 crate28)
	(at crate62 distributor6)
	(on crate62 crate46)
	(at crate63 depot0)
	(on crate63 crate43)
)

(:goal (and
		(on crate0 crate32)
		(on crate1 crate21)
		(on crate2 pallet14)
		(on crate4 crate31)
		(on crate5 crate29)
		(on crate6 crate38)
		(on crate7 pallet6)
		(on crate9 crate10)
		(on crate10 crate47)
		(on crate11 crate53)
		(on crate12 crate39)
		(on crate13 crate12)
		(on crate15 pallet3)
		(on crate16 pallet12)
		(on crate17 pallet10)
		(on crate18 crate28)
		(on crate19 crate55)
		(on crate20 crate27)
		(on crate21 crate17)
		(on crate22 pallet8)
		(on crate23 pallet15)
		(on crate25 crate54)
		(on crate26 crate22)
		(on crate27 crate49)
		(on crate28 pallet4)
		(on crate29 crate15)
		(on crate30 crate59)
		(on crate31 crate41)
		(on crate32 pallet2)
		(on crate33 crate34)
		(on crate34 crate44)
		(on crate35 pallet1)
		(on crate36 crate0)
		(on crate37 crate33)
		(on crate38 crate36)
		(on crate39 crate25)
		(on crate41 pallet5)
		(on crate42 crate35)
		(on crate43 crate4)
		(on crate44 pallet0)
		(on crate45 crate23)
		(on crate46 pallet13)
		(on crate47 crate2)
		(on crate48 crate45)
		(on crate49 pallet7)
		(on crate51 pallet9)
		(on crate52 crate16)
		(on crate53 crate18)
		(on crate54 crate30)
		(on crate55 pallet11)
		(on crate57 crate1)
		(on crate58 crate61)
		(on crate59 crate46)
		(on crate61 crate51)
		(on crate62 crate48)
		(on crate63 crate42)
	)
))
