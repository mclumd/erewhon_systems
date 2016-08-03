(define (problem depotprob220) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate62)
	(at pallet1 depot1)
	(clear crate42)
	(at pallet2 depot2)
	(clear crate79)
	(at pallet3 depot3)
	(clear crate33)
	(at pallet4 depot4)
	(clear crate48)
	(at pallet5 depot5)
	(clear crate75)
	(at pallet6 depot6)
	(clear crate64)
	(at pallet7 depot7)
	(clear crate58)
	(at pallet8 depot8)
	(clear crate71)
	(at pallet9 depot9)
	(clear crate66)
	(at pallet10 distributor0)
	(clear crate63)
	(at pallet11 distributor1)
	(clear crate70)
	(at pallet12 distributor2)
	(clear crate53)
	(at pallet13 distributor3)
	(clear crate78)
	(at pallet14 distributor4)
	(clear crate73)
	(at pallet15 distributor5)
	(clear crate51)
	(at pallet16 distributor6)
	(clear crate76)
	(at pallet17 distributor7)
	(clear crate67)
	(at pallet18 distributor8)
	(clear crate77)
	(at pallet19 distributor9)
	(clear crate74)
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
	(at hoist8 depot8)
	(available hoist8)
	(at hoist9 depot9)
	(available hoist9)
	(at hoist10 distributor0)
	(available hoist10)
	(at hoist11 distributor1)
	(available hoist11)
	(at hoist12 distributor2)
	(available hoist12)
	(at hoist13 distributor3)
	(available hoist13)
	(at hoist14 distributor4)
	(available hoist14)
	(at hoist15 distributor5)
	(available hoist15)
	(at hoist16 distributor6)
	(available hoist16)
	(at hoist17 distributor7)
	(available hoist17)
	(at hoist18 distributor8)
	(available hoist18)
	(at hoist19 distributor9)
	(available hoist19)
	(at crate0 distributor1)
	(on crate0 pallet11)
	(at crate1 distributor2)
	(on crate1 pallet12)
	(at crate2 depot6)
	(on crate2 pallet6)
	(at crate3 depot8)
	(on crate3 pallet8)
	(at crate4 depot6)
	(on crate4 crate2)
	(at crate5 distributor1)
	(on crate5 crate0)
	(at crate6 distributor7)
	(on crate6 pallet17)
	(at crate7 depot9)
	(on crate7 pallet9)
	(at crate8 depot1)
	(on crate8 pallet1)
	(at crate9 distributor4)
	(on crate9 pallet14)
	(at crate10 distributor9)
	(on crate10 pallet19)
	(at crate11 distributor4)
	(on crate11 crate9)
	(at crate12 distributor6)
	(on crate12 pallet16)
	(at crate13 distributor4)
	(on crate13 crate11)
	(at crate14 depot9)
	(on crate14 crate7)
	(at crate15 depot6)
	(on crate15 crate4)
	(at crate16 depot4)
	(on crate16 pallet4)
	(at crate17 distributor0)
	(on crate17 pallet10)
	(at crate18 depot1)
	(on crate18 crate8)
	(at crate19 distributor8)
	(on crate19 pallet18)
	(at crate20 distributor2)
	(on crate20 crate1)
	(at crate21 distributor0)
	(on crate21 crate17)
	(at crate22 depot7)
	(on crate22 pallet7)
	(at crate23 distributor5)
	(on crate23 pallet15)
	(at crate24 distributor6)
	(on crate24 crate12)
	(at crate25 depot8)
	(on crate25 crate3)
	(at crate26 depot4)
	(on crate26 crate16)
	(at crate27 distributor0)
	(on crate27 crate21)
	(at crate28 distributor0)
	(on crate28 crate27)
	(at crate29 distributor7)
	(on crate29 crate6)
	(at crate30 depot8)
	(on crate30 crate25)
	(at crate31 depot0)
	(on crate31 pallet0)
	(at crate32 depot3)
	(on crate32 pallet3)
	(at crate33 depot3)
	(on crate33 crate32)
	(at crate34 depot9)
	(on crate34 crate14)
	(at crate35 distributor2)
	(on crate35 crate20)
	(at crate36 distributor3)
	(on crate36 pallet13)
	(at crate37 distributor1)
	(on crate37 crate5)
	(at crate38 depot1)
	(on crate38 crate18)
	(at crate39 depot9)
	(on crate39 crate34)
	(at crate40 distributor7)
	(on crate40 crate29)
	(at crate41 distributor4)
	(on crate41 crate13)
	(at crate42 depot1)
	(on crate42 crate38)
	(at crate43 depot2)
	(on crate43 pallet2)
	(at crate44 distributor0)
	(on crate44 crate28)
	(at crate45 distributor2)
	(on crate45 crate35)
	(at crate46 depot4)
	(on crate46 crate26)
	(at crate47 distributor2)
	(on crate47 crate45)
	(at crate48 depot4)
	(on crate48 crate46)
	(at crate49 distributor3)
	(on crate49 crate36)
	(at crate50 distributor8)
	(on crate50 crate19)
	(at crate51 distributor5)
	(on crate51 crate23)
	(at crate52 depot8)
	(on crate52 crate30)
	(at crate53 distributor2)
	(on crate53 crate47)
	(at crate54 distributor4)
	(on crate54 crate41)
	(at crate55 depot8)
	(on crate55 crate52)
	(at crate56 depot0)
	(on crate56 crate31)
	(at crate57 distributor4)
	(on crate57 crate54)
	(at crate58 depot7)
	(on crate58 crate22)
	(at crate59 distributor4)
	(on crate59 crate57)
	(at crate60 distributor7)
	(on crate60 crate40)
	(at crate61 distributor7)
	(on crate61 crate60)
	(at crate62 depot0)
	(on crate62 crate56)
	(at crate63 distributor0)
	(on crate63 crate44)
	(at crate64 depot6)
	(on crate64 crate15)
	(at crate65 distributor9)
	(on crate65 crate10)
	(at crate66 depot9)
	(on crate66 crate39)
	(at crate67 distributor7)
	(on crate67 crate61)
	(at crate68 depot2)
	(on crate68 crate43)
	(at crate69 depot8)
	(on crate69 crate55)
	(at crate70 distributor1)
	(on crate70 crate37)
	(at crate71 depot8)
	(on crate71 crate69)
	(at crate72 distributor9)
	(on crate72 crate65)
	(at crate73 distributor4)
	(on crate73 crate59)
	(at crate74 distributor9)
	(on crate74 crate72)
	(at crate75 depot5)
	(on crate75 pallet5)
	(at crate76 distributor6)
	(on crate76 crate24)
	(at crate77 distributor8)
	(on crate77 crate50)
	(at crate78 distributor3)
	(on crate78 crate49)
	(at crate79 depot2)
	(on crate79 crate68)
)

(:goal (and
		(on crate0 pallet13)
		(on crate1 crate54)
		(on crate2 crate41)
		(on crate3 crate5)
		(on crate4 crate60)
		(on crate5 pallet7)
		(on crate7 crate0)
		(on crate8 crate77)
		(on crate9 pallet5)
		(on crate10 pallet17)
		(on crate11 pallet0)
		(on crate12 crate4)
		(on crate13 crate17)
		(on crate14 crate1)
		(on crate15 crate62)
		(on crate16 crate10)
		(on crate17 crate9)
		(on crate18 crate35)
		(on crate21 crate42)
		(on crate22 crate11)
		(on crate23 crate28)
		(on crate24 crate37)
		(on crate26 crate43)
		(on crate27 crate14)
		(on crate28 pallet10)
		(on crate29 pallet15)
		(on crate30 crate27)
		(on crate31 crate57)
		(on crate32 crate55)
		(on crate33 crate71)
		(on crate34 crate8)
		(on crate35 pallet16)
		(on crate36 crate22)
		(on crate37 crate45)
		(on crate38 crate67)
		(on crate40 crate50)
		(on crate41 crate47)
		(on crate42 pallet8)
		(on crate43 crate66)
		(on crate44 pallet6)
		(on crate45 crate21)
		(on crate46 crate34)
		(on crate47 crate74)
		(on crate48 pallet14)
		(on crate49 pallet2)
		(on crate50 crate26)
		(on crate51 pallet11)
		(on crate54 crate64)
		(on crate55 crate13)
		(on crate57 crate29)
		(on crate58 crate44)
		(on crate59 crate63)
		(on crate60 pallet1)
		(on crate61 crate33)
		(on crate62 crate7)
		(on crate63 pallet19)
		(on crate64 crate78)
		(on crate65 crate73)
		(on crate66 crate51)
		(on crate67 crate79)
		(on crate68 crate59)
		(on crate69 pallet9)
		(on crate71 pallet4)
		(on crate72 crate58)
		(on crate73 pallet18)
		(on crate74 crate23)
		(on crate75 crate32)
		(on crate76 crate2)
		(on crate77 crate18)
		(on crate78 pallet12)
		(on crate79 pallet3)
	)
))
