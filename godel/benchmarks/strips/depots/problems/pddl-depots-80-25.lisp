(define (problem depotprob250) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate57)
	(at pallet1 depot1)
	(clear crate74)
	(at pallet2 depot2)
	(clear crate45)
	(at pallet3 depot3)
	(clear crate29)
	(at pallet4 depot4)
	(clear crate78)
	(at pallet5 depot5)
	(clear crate55)
	(at pallet6 depot6)
	(clear crate65)
	(at pallet7 depot7)
	(clear crate73)
	(at pallet8 depot8)
	(clear crate77)
	(at pallet9 depot9)
	(clear crate19)
	(at pallet10 distributor0)
	(clear crate68)
	(at pallet11 distributor1)
	(clear crate63)
	(at pallet12 distributor2)
	(clear crate51)
	(at pallet13 distributor3)
	(clear crate69)
	(at pallet14 distributor4)
	(clear crate79)
	(at pallet15 distributor5)
	(clear crate59)
	(at pallet16 distributor6)
	(clear crate11)
	(at pallet17 distributor7)
	(clear crate67)
	(at pallet18 distributor8)
	(clear crate62)
	(at pallet19 distributor9)
	(clear crate76)
	(at truck0 distributor3)
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
	(at crate1 depot6)
	(on crate1 pallet6)
	(at crate2 depot2)
	(on crate2 pallet2)
	(at crate3 distributor4)
	(on crate3 pallet14)
	(at crate4 depot3)
	(on crate4 pallet3)
	(at crate5 depot5)
	(on crate5 pallet5)
	(at crate6 depot2)
	(on crate6 crate2)
	(at crate7 distributor9)
	(on crate7 pallet19)
	(at crate8 distributor2)
	(on crate8 pallet12)
	(at crate9 depot4)
	(on crate9 pallet4)
	(at crate10 depot0)
	(on crate10 pallet0)
	(at crate11 distributor6)
	(on crate11 pallet16)
	(at crate12 distributor7)
	(on crate12 pallet17)
	(at crate13 distributor9)
	(on crate13 crate7)
	(at crate14 distributor7)
	(on crate14 crate12)
	(at crate15 depot5)
	(on crate15 crate5)
	(at crate16 depot9)
	(on crate16 pallet9)
	(at crate17 distributor9)
	(on crate17 crate13)
	(at crate18 distributor3)
	(on crate18 pallet13)
	(at crate19 depot9)
	(on crate19 crate16)
	(at crate20 distributor2)
	(on crate20 crate8)
	(at crate21 distributor1)
	(on crate21 crate0)
	(at crate22 distributor0)
	(on crate22 pallet10)
	(at crate23 distributor0)
	(on crate23 crate22)
	(at crate24 depot2)
	(on crate24 crate6)
	(at crate25 depot4)
	(on crate25 crate9)
	(at crate26 distributor2)
	(on crate26 crate20)
	(at crate27 distributor2)
	(on crate27 crate26)
	(at crate28 distributor1)
	(on crate28 crate21)
	(at crate29 depot3)
	(on crate29 crate4)
	(at crate30 distributor5)
	(on crate30 pallet15)
	(at crate31 distributor8)
	(on crate31 pallet18)
	(at crate32 depot1)
	(on crate32 pallet1)
	(at crate33 distributor7)
	(on crate33 crate14)
	(at crate34 distributor0)
	(on crate34 crate23)
	(at crate35 distributor2)
	(on crate35 crate27)
	(at crate36 depot2)
	(on crate36 crate24)
	(at crate37 distributor8)
	(on crate37 crate31)
	(at crate38 distributor5)
	(on crate38 crate30)
	(at crate39 distributor5)
	(on crate39 crate38)
	(at crate40 depot4)
	(on crate40 crate25)
	(at crate41 depot0)
	(on crate41 crate10)
	(at crate42 depot1)
	(on crate42 crate32)
	(at crate43 depot5)
	(on crate43 crate15)
	(at crate44 depot5)
	(on crate44 crate43)
	(at crate45 depot2)
	(on crate45 crate36)
	(at crate46 distributor7)
	(on crate46 crate33)
	(at crate47 depot5)
	(on crate47 crate44)
	(at crate48 distributor8)
	(on crate48 crate37)
	(at crate49 distributor4)
	(on crate49 crate3)
	(at crate50 distributor0)
	(on crate50 crate34)
	(at crate51 distributor2)
	(on crate51 crate35)
	(at crate52 distributor1)
	(on crate52 crate28)
	(at crate53 depot5)
	(on crate53 crate47)
	(at crate54 depot0)
	(on crate54 crate41)
	(at crate55 depot5)
	(on crate55 crate53)
	(at crate56 depot0)
	(on crate56 crate54)
	(at crate57 depot0)
	(on crate57 crate56)
	(at crate58 distributor9)
	(on crate58 crate17)
	(at crate59 distributor5)
	(on crate59 crate39)
	(at crate60 distributor4)
	(on crate60 crate49)
	(at crate61 depot4)
	(on crate61 crate40)
	(at crate62 distributor8)
	(on crate62 crate48)
	(at crate63 distributor1)
	(on crate63 crate52)
	(at crate64 distributor3)
	(on crate64 crate18)
	(at crate65 depot6)
	(on crate65 crate1)
	(at crate66 distributor3)
	(on crate66 crate64)
	(at crate67 distributor7)
	(on crate67 crate46)
	(at crate68 distributor0)
	(on crate68 crate50)
	(at crate69 distributor3)
	(on crate69 crate66)
	(at crate70 depot4)
	(on crate70 crate61)
	(at crate71 distributor4)
	(on crate71 crate60)
	(at crate72 depot4)
	(on crate72 crate70)
	(at crate73 depot7)
	(on crate73 pallet7)
	(at crate74 depot1)
	(on crate74 crate42)
	(at crate75 depot8)
	(on crate75 pallet8)
	(at crate76 distributor9)
	(on crate76 crate58)
	(at crate77 depot8)
	(on crate77 crate75)
	(at crate78 depot4)
	(on crate78 crate72)
	(at crate79 distributor4)
	(on crate79 crate71)
)

(:goal (and
		(on crate0 crate46)
		(on crate1 pallet7)
		(on crate2 crate9)
		(on crate3 pallet2)
		(on crate4 crate42)
		(on crate5 crate73)
		(on crate6 pallet16)
		(on crate7 pallet14)
		(on crate9 crate15)
		(on crate10 crate49)
		(on crate11 crate40)
		(on crate12 pallet0)
		(on crate13 crate67)
		(on crate14 crate16)
		(on crate15 crate1)
		(on crate16 crate66)
		(on crate17 crate7)
		(on crate18 crate35)
		(on crate19 crate51)
		(on crate20 crate74)
		(on crate21 crate4)
		(on crate22 pallet5)
		(on crate23 crate24)
		(on crate24 crate32)
		(on crate25 crate23)
		(on crate26 crate25)
		(on crate27 pallet9)
		(on crate28 crate5)
		(on crate30 pallet12)
		(on crate31 crate13)
		(on crate32 crate75)
		(on crate33 crate61)
		(on crate34 crate47)
		(on crate35 pallet1)
		(on crate36 crate34)
		(on crate37 crate10)
		(on crate38 crate58)
		(on crate40 pallet17)
		(on crate42 crate78)
		(on crate44 crate33)
		(on crate45 crate50)
		(on crate46 crate12)
		(on crate47 pallet3)
		(on crate49 pallet8)
		(on crate50 crate38)
		(on crate51 pallet4)
		(on crate52 crate11)
		(on crate54 crate19)
		(on crate55 crate6)
		(on crate57 crate30)
		(on crate58 pallet18)
		(on crate59 crate72)
		(on crate60 crate45)
		(on crate61 pallet10)
		(on crate62 crate31)
		(on crate64 crate3)
		(on crate65 pallet13)
		(on crate66 crate71)
		(on crate67 crate20)
		(on crate68 crate59)
		(on crate69 crate55)
		(on crate70 crate22)
		(on crate71 crate57)
		(on crate72 pallet6)
		(on crate73 crate65)
		(on crate74 pallet15)
		(on crate75 pallet11)
		(on crate76 crate27)
		(on crate78 pallet19)
	)
))
