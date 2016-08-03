(define (problem depotprob160) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate79)
	(at pallet1 depot1)
	(clear crate72)
	(at pallet2 depot2)
	(clear crate67)
	(at pallet3 depot3)
	(clear crate77)
	(at pallet4 depot4)
	(clear crate61)
	(at pallet5 depot5)
	(clear crate31)
	(at pallet6 depot6)
	(clear crate60)
	(at pallet7 depot7)
	(clear crate55)
	(at pallet8 depot8)
	(clear crate78)
	(at pallet9 depot9)
	(clear crate68)
	(at pallet10 distributor0)
	(clear crate59)
	(at pallet11 distributor1)
	(clear crate45)
	(at pallet12 distributor2)
	(clear crate22)
	(at pallet13 distributor3)
	(clear crate57)
	(at pallet14 distributor4)
	(clear crate47)
	(at pallet15 distributor5)
	(clear crate6)
	(at pallet16 distributor6)
	(clear crate76)
	(at pallet17 distributor7)
	(clear crate65)
	(at pallet18 distributor8)
	(clear crate11)
	(at pallet19 distributor9)
	(clear crate62)
	(at truck0 depot6)
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
	(at crate0 distributor4)
	(on crate0 pallet14)
	(at crate1 depot8)
	(on crate1 pallet8)
	(at crate2 depot1)
	(on crate2 pallet1)
	(at crate3 distributor9)
	(on crate3 pallet19)
	(at crate4 depot6)
	(on crate4 pallet6)
	(at crate5 depot1)
	(on crate5 crate2)
	(at crate6 distributor5)
	(on crate6 pallet15)
	(at crate7 depot9)
	(on crate7 pallet9)
	(at crate8 distributor1)
	(on crate8 pallet11)
	(at crate9 distributor3)
	(on crate9 pallet13)
	(at crate10 depot4)
	(on crate10 pallet4)
	(at crate11 distributor8)
	(on crate11 pallet18)
	(at crate12 distributor0)
	(on crate12 pallet10)
	(at crate13 depot9)
	(on crate13 crate7)
	(at crate14 distributor4)
	(on crate14 crate0)
	(at crate15 distributor4)
	(on crate15 crate14)
	(at crate16 distributor1)
	(on crate16 crate8)
	(at crate17 depot1)
	(on crate17 crate5)
	(at crate18 depot1)
	(on crate18 crate17)
	(at crate19 depot2)
	(on crate19 pallet2)
	(at crate20 distributor6)
	(on crate20 pallet16)
	(at crate21 distributor2)
	(on crate21 pallet12)
	(at crate22 distributor2)
	(on crate22 crate21)
	(at crate23 depot9)
	(on crate23 crate13)
	(at crate24 depot7)
	(on crate24 pallet7)
	(at crate25 depot7)
	(on crate25 crate24)
	(at crate26 distributor4)
	(on crate26 crate15)
	(at crate27 depot7)
	(on crate27 crate25)
	(at crate28 depot2)
	(on crate28 crate19)
	(at crate29 distributor6)
	(on crate29 crate20)
	(at crate30 distributor0)
	(on crate30 crate12)
	(at crate31 depot5)
	(on crate31 pallet5)
	(at crate32 distributor3)
	(on crate32 crate9)
	(at crate33 distributor4)
	(on crate33 crate26)
	(at crate34 depot7)
	(on crate34 crate27)
	(at crate35 depot4)
	(on crate35 crate10)
	(at crate36 depot1)
	(on crate36 crate18)
	(at crate37 distributor6)
	(on crate37 crate29)
	(at crate38 distributor7)
	(on crate38 pallet17)
	(at crate39 distributor7)
	(on crate39 crate38)
	(at crate40 depot9)
	(on crate40 crate23)
	(at crate41 distributor7)
	(on crate41 crate39)
	(at crate42 distributor1)
	(on crate42 crate16)
	(at crate43 depot8)
	(on crate43 crate1)
	(at crate44 depot2)
	(on crate44 crate28)
	(at crate45 distributor1)
	(on crate45 crate42)
	(at crate46 distributor4)
	(on crate46 crate33)
	(at crate47 distributor4)
	(on crate47 crate46)
	(at crate48 depot4)
	(on crate48 crate35)
	(at crate49 depot4)
	(on crate49 crate48)
	(at crate50 depot6)
	(on crate50 crate4)
	(at crate51 distributor7)
	(on crate51 crate41)
	(at crate52 depot4)
	(on crate52 crate49)
	(at crate53 depot1)
	(on crate53 crate36)
	(at crate54 depot0)
	(on crate54 pallet0)
	(at crate55 depot7)
	(on crate55 crate34)
	(at crate56 depot4)
	(on crate56 crate52)
	(at crate57 distributor3)
	(on crate57 crate32)
	(at crate58 distributor0)
	(on crate58 crate30)
	(at crate59 distributor0)
	(on crate59 crate58)
	(at crate60 depot6)
	(on crate60 crate50)
	(at crate61 depot4)
	(on crate61 crate56)
	(at crate62 distributor9)
	(on crate62 crate3)
	(at crate63 depot9)
	(on crate63 crate40)
	(at crate64 depot8)
	(on crate64 crate43)
	(at crate65 distributor7)
	(on crate65 crate51)
	(at crate66 depot1)
	(on crate66 crate53)
	(at crate67 depot2)
	(on crate67 crate44)
	(at crate68 depot9)
	(on crate68 crate63)
	(at crate69 depot8)
	(on crate69 crate64)
	(at crate70 depot3)
	(on crate70 pallet3)
	(at crate71 depot0)
	(on crate71 crate54)
	(at crate72 depot1)
	(on crate72 crate66)
	(at crate73 depot3)
	(on crate73 crate70)
	(at crate74 distributor6)
	(on crate74 crate37)
	(at crate75 depot3)
	(on crate75 crate73)
	(at crate76 distributor6)
	(on crate76 crate74)
	(at crate77 depot3)
	(on crate77 crate75)
	(at crate78 depot8)
	(on crate78 crate69)
	(at crate79 depot0)
	(on crate79 crate71)
)

(:goal (and
		(on crate0 crate63)
		(on crate1 crate25)
		(on crate3 crate6)
		(on crate4 crate72)
		(on crate6 pallet18)
		(on crate7 crate70)
		(on crate8 crate17)
		(on crate9 crate21)
		(on crate10 crate48)
		(on crate11 crate15)
		(on crate12 crate47)
		(on crate13 pallet14)
		(on crate14 pallet16)
		(on crate15 pallet7)
		(on crate16 pallet4)
		(on crate17 crate35)
		(on crate18 crate55)
		(on crate19 crate57)
		(on crate20 crate27)
		(on crate21 crate71)
		(on crate22 pallet3)
		(on crate23 crate56)
		(on crate24 crate67)
		(on crate25 crate32)
		(on crate27 crate33)
		(on crate28 crate79)
		(on crate29 pallet12)
		(on crate30 crate65)
		(on crate32 pallet15)
		(on crate33 crate59)
		(on crate34 crate66)
		(on crate35 pallet17)
		(on crate38 crate3)
		(on crate39 crate12)
		(on crate40 pallet19)
		(on crate41 crate61)
		(on crate42 crate75)
		(on crate43 pallet8)
		(on crate44 crate8)
		(on crate45 pallet1)
		(on crate46 crate29)
		(on crate47 crate69)
		(on crate48 crate19)
		(on crate50 pallet9)
		(on crate51 pallet10)
		(on crate53 crate14)
		(on crate54 crate28)
		(on crate55 crate46)
		(on crate56 pallet13)
		(on crate57 pallet6)
		(on crate59 crate11)
		(on crate60 crate62)
		(on crate61 crate34)
		(on crate62 crate43)
		(on crate63 crate24)
		(on crate65 crate53)
		(on crate66 pallet5)
		(on crate67 crate13)
		(on crate68 crate4)
		(on crate69 crate40)
		(on crate70 pallet11)
		(on crate71 crate78)
		(on crate72 crate51)
		(on crate73 crate7)
		(on crate74 crate60)
		(on crate75 crate50)
		(on crate76 crate10)
		(on crate77 crate18)
		(on crate78 pallet0)
		(on crate79 crate73)
	)
))