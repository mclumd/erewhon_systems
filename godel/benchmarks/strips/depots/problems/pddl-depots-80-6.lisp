(define (problem depotprob60) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate55)
	(at pallet1 depot1)
	(clear crate75)
	(at pallet2 depot2)
	(clear crate66)
	(at pallet3 depot3)
	(clear crate74)
	(at pallet4 depot4)
	(clear crate77)
	(at pallet5 depot5)
	(clear crate50)
	(at pallet6 depot6)
	(clear crate79)
	(at pallet7 depot7)
	(clear crate43)
	(at pallet8 depot8)
	(clear crate47)
	(at pallet9 depot9)
	(clear crate68)
	(at pallet10 distributor0)
	(clear crate37)
	(at pallet11 distributor1)
	(clear crate73)
	(at pallet12 distributor2)
	(clear crate4)
	(at pallet13 distributor3)
	(clear crate60)
	(at pallet14 distributor4)
	(clear crate78)
	(at pallet15 distributor5)
	(clear crate62)
	(at pallet16 distributor6)
	(clear crate71)
	(at pallet17 distributor7)
	(clear crate72)
	(at pallet18 distributor8)
	(clear crate76)
	(at pallet19 distributor9)
	(clear crate69)
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
	(at crate0 depot4)
	(on crate0 pallet4)
	(at crate1 distributor0)
	(on crate1 pallet10)
	(at crate2 depot1)
	(on crate2 pallet1)
	(at crate3 depot6)
	(on crate3 pallet6)
	(at crate4 distributor2)
	(on crate4 pallet12)
	(at crate5 distributor1)
	(on crate5 pallet11)
	(at crate6 depot1)
	(on crate6 crate2)
	(at crate7 depot0)
	(on crate7 pallet0)
	(at crate8 distributor1)
	(on crate8 crate5)
	(at crate9 depot6)
	(on crate9 crate3)
	(at crate10 distributor1)
	(on crate10 crate8)
	(at crate11 distributor0)
	(on crate11 crate1)
	(at crate12 distributor1)
	(on crate12 crate10)
	(at crate13 distributor7)
	(on crate13 pallet17)
	(at crate14 distributor3)
	(on crate14 pallet13)
	(at crate15 depot9)
	(on crate15 pallet9)
	(at crate16 distributor7)
	(on crate16 crate13)
	(at crate17 distributor8)
	(on crate17 pallet18)
	(at crate18 distributor1)
	(on crate18 crate12)
	(at crate19 depot7)
	(on crate19 pallet7)
	(at crate20 distributor3)
	(on crate20 crate14)
	(at crate21 distributor1)
	(on crate21 crate18)
	(at crate22 depot5)
	(on crate22 pallet5)
	(at crate23 depot0)
	(on crate23 crate7)
	(at crate24 distributor8)
	(on crate24 crate17)
	(at crate25 distributor5)
	(on crate25 pallet15)
	(at crate26 depot9)
	(on crate26 crate15)
	(at crate27 distributor0)
	(on crate27 crate11)
	(at crate28 depot7)
	(on crate28 crate19)
	(at crate29 distributor8)
	(on crate29 crate24)
	(at crate30 depot8)
	(on crate30 pallet8)
	(at crate31 distributor8)
	(on crate31 crate29)
	(at crate32 depot8)
	(on crate32 crate30)
	(at crate33 depot4)
	(on crate33 crate0)
	(at crate34 depot1)
	(on crate34 crate6)
	(at crate35 depot4)
	(on crate35 crate33)
	(at crate36 distributor1)
	(on crate36 crate21)
	(at crate37 distributor0)
	(on crate37 crate27)
	(at crate38 depot8)
	(on crate38 crate32)
	(at crate39 distributor3)
	(on crate39 crate20)
	(at crate40 distributor8)
	(on crate40 crate31)
	(at crate41 distributor7)
	(on crate41 crate16)
	(at crate42 distributor4)
	(on crate42 pallet14)
	(at crate43 depot7)
	(on crate43 crate28)
	(at crate44 distributor4)
	(on crate44 crate42)
	(at crate45 depot2)
	(on crate45 pallet2)
	(at crate46 distributor4)
	(on crate46 crate44)
	(at crate47 depot8)
	(on crate47 crate38)
	(at crate48 distributor7)
	(on crate48 crate41)
	(at crate49 depot3)
	(on crate49 pallet3)
	(at crate50 depot5)
	(on crate50 crate22)
	(at crate51 distributor3)
	(on crate51 crate39)
	(at crate52 depot4)
	(on crate52 crate35)
	(at crate53 distributor3)
	(on crate53 crate51)
	(at crate54 distributor4)
	(on crate54 crate46)
	(at crate55 depot0)
	(on crate55 crate23)
	(at crate56 distributor5)
	(on crate56 crate25)
	(at crate57 distributor9)
	(on crate57 pallet19)
	(at crate58 depot4)
	(on crate58 crate52)
	(at crate59 distributor1)
	(on crate59 crate36)
	(at crate60 distributor3)
	(on crate60 crate53)
	(at crate61 depot2)
	(on crate61 crate45)
	(at crate62 distributor5)
	(on crate62 crate56)
	(at crate63 distributor1)
	(on crate63 crate59)
	(at crate64 depot4)
	(on crate64 crate58)
	(at crate65 distributor1)
	(on crate65 crate63)
	(at crate66 depot2)
	(on crate66 crate61)
	(at crate67 depot6)
	(on crate67 crate9)
	(at crate68 depot9)
	(on crate68 crate26)
	(at crate69 distributor9)
	(on crate69 crate57)
	(at crate70 depot6)
	(on crate70 crate67)
	(at crate71 distributor6)
	(on crate71 pallet16)
	(at crate72 distributor7)
	(on crate72 crate48)
	(at crate73 distributor1)
	(on crate73 crate65)
	(at crate74 depot3)
	(on crate74 crate49)
	(at crate75 depot1)
	(on crate75 crate34)
	(at crate76 distributor8)
	(on crate76 crate40)
	(at crate77 depot4)
	(on crate77 crate64)
	(at crate78 distributor4)
	(on crate78 crate54)
	(at crate79 depot6)
	(on crate79 crate70)
)

(:goal (and
		(on crate1 crate45)
		(on crate2 crate59)
		(on crate4 crate20)
		(on crate6 crate27)
		(on crate7 crate4)
		(on crate8 pallet10)
		(on crate10 crate40)
		(on crate11 pallet12)
		(on crate12 crate6)
		(on crate13 crate48)
		(on crate15 pallet4)
		(on crate16 crate7)
		(on crate17 crate35)
		(on crate19 crate73)
		(on crate20 pallet11)
		(on crate21 crate79)
		(on crate22 crate10)
		(on crate24 crate58)
		(on crate25 pallet7)
		(on crate26 crate43)
		(on crate27 crate15)
		(on crate28 crate69)
		(on crate30 crate17)
		(on crate31 pallet6)
		(on crate32 crate42)
		(on crate33 crate53)
		(on crate34 pallet15)
		(on crate35 crate77)
		(on crate36 crate37)
		(on crate37 crate52)
		(on crate38 crate44)
		(on crate39 crate26)
		(on crate40 crate74)
		(on crate42 pallet17)
		(on crate43 crate49)
		(on crate44 crate70)
		(on crate45 crate36)
		(on crate46 crate24)
		(on crate47 pallet13)
		(on crate48 crate11)
		(on crate49 pallet3)
		(on crate51 crate47)
		(on crate52 pallet14)
		(on crate53 pallet2)
		(on crate54 crate62)
		(on crate56 crate65)
		(on crate57 crate72)
		(on crate58 pallet18)
		(on crate59 pallet19)
		(on crate60 crate25)
		(on crate61 pallet5)
		(on crate62 pallet0)
		(on crate65 crate32)
		(on crate66 pallet1)
		(on crate67 crate75)
		(on crate68 crate19)
		(on crate69 crate57)
		(on crate70 crate61)
		(on crate72 pallet8)
		(on crate73 crate33)
		(on crate74 crate2)
		(on crate75 pallet9)
		(on crate76 crate28)
		(on crate77 pallet16)
		(on crate79 crate67)
	)
))
