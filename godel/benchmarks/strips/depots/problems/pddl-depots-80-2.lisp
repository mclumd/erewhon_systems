(define (problem depotprob20) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate69)
	(at pallet1 depot1)
	(clear crate62)
	(at pallet2 depot2)
	(clear crate67)
	(at pallet3 depot3)
	(clear crate78)
	(at pallet4 depot4)
	(clear crate72)
	(at pallet5 depot5)
	(clear crate79)
	(at pallet6 depot6)
	(clear crate60)
	(at pallet7 depot7)
	(clear crate71)
	(at pallet8 depot8)
	(clear crate66)
	(at pallet9 depot9)
	(clear crate51)
	(at pallet10 distributor0)
	(clear crate12)
	(at pallet11 distributor1)
	(clear crate48)
	(at pallet12 distributor2)
	(clear crate76)
	(at pallet13 distributor3)
	(clear crate41)
	(at pallet14 distributor4)
	(clear crate55)
	(at pallet15 distributor5)
	(clear crate77)
	(at pallet16 distributor6)
	(clear crate45)
	(at pallet17 distributor7)
	(clear crate73)
	(at pallet18 distributor8)
	(clear crate75)
	(at pallet19 distributor9)
	(clear crate68)
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
	(at crate0 distributor7)
	(on crate0 pallet17)
	(at crate1 depot8)
	(on crate1 pallet8)
	(at crate2 distributor8)
	(on crate2 pallet18)
	(at crate3 distributor3)
	(on crate3 pallet13)
	(at crate4 depot0)
	(on crate4 pallet0)
	(at crate5 distributor8)
	(on crate5 crate2)
	(at crate6 distributor2)
	(on crate6 pallet12)
	(at crate7 distributor8)
	(on crate7 crate5)
	(at crate8 depot6)
	(on crate8 pallet6)
	(at crate9 distributor2)
	(on crate9 crate6)
	(at crate10 distributor9)
	(on crate10 pallet19)
	(at crate11 depot7)
	(on crate11 pallet7)
	(at crate12 distributor0)
	(on crate12 pallet10)
	(at crate13 depot5)
	(on crate13 pallet5)
	(at crate14 distributor5)
	(on crate14 pallet15)
	(at crate15 depot8)
	(on crate15 crate1)
	(at crate16 depot2)
	(on crate16 pallet2)
	(at crate17 distributor6)
	(on crate17 pallet16)
	(at crate18 depot2)
	(on crate18 crate16)
	(at crate19 distributor5)
	(on crate19 crate14)
	(at crate20 depot6)
	(on crate20 crate8)
	(at crate21 distributor2)
	(on crate21 crate9)
	(at crate22 depot4)
	(on crate22 pallet4)
	(at crate23 depot1)
	(on crate23 pallet1)
	(at crate24 distributor6)
	(on crate24 crate17)
	(at crate25 distributor7)
	(on crate25 crate0)
	(at crate26 depot2)
	(on crate26 crate18)
	(at crate27 depot2)
	(on crate27 crate26)
	(at crate28 depot0)
	(on crate28 crate4)
	(at crate29 depot8)
	(on crate29 crate15)
	(at crate30 depot7)
	(on crate30 crate11)
	(at crate31 depot9)
	(on crate31 pallet9)
	(at crate32 distributor3)
	(on crate32 crate3)
	(at crate33 distributor1)
	(on crate33 pallet11)
	(at crate34 distributor5)
	(on crate34 crate19)
	(at crate35 distributor7)
	(on crate35 crate25)
	(at crate36 depot1)
	(on crate36 crate23)
	(at crate37 depot2)
	(on crate37 crate27)
	(at crate38 depot1)
	(on crate38 crate36)
	(at crate39 distributor7)
	(on crate39 crate35)
	(at crate40 distributor7)
	(on crate40 crate39)
	(at crate41 distributor3)
	(on crate41 crate32)
	(at crate42 distributor9)
	(on crate42 crate10)
	(at crate43 distributor2)
	(on crate43 crate21)
	(at crate44 depot4)
	(on crate44 crate22)
	(at crate45 distributor6)
	(on crate45 crate24)
	(at crate46 distributor7)
	(on crate46 crate40)
	(at crate47 depot2)
	(on crate47 crate37)
	(at crate48 distributor1)
	(on crate48 crate33)
	(at crate49 depot7)
	(on crate49 crate30)
	(at crate50 depot1)
	(on crate50 crate38)
	(at crate51 depot9)
	(on crate51 crate31)
	(at crate52 distributor5)
	(on crate52 crate34)
	(at crate53 depot8)
	(on crate53 crate29)
	(at crate54 distributor4)
	(on crate54 pallet14)
	(at crate55 distributor4)
	(on crate55 crate54)
	(at crate56 depot0)
	(on crate56 crate28)
	(at crate57 distributor2)
	(on crate57 crate43)
	(at crate58 depot5)
	(on crate58 crate13)
	(at crate59 distributor9)
	(on crate59 crate42)
	(at crate60 depot6)
	(on crate60 crate20)
	(at crate61 depot1)
	(on crate61 crate50)
	(at crate62 depot1)
	(on crate62 crate61)
	(at crate63 distributor5)
	(on crate63 crate52)
	(at crate64 distributor8)
	(on crate64 crate7)
	(at crate65 distributor9)
	(on crate65 crate59)
	(at crate66 depot8)
	(on crate66 crate53)
	(at crate67 depot2)
	(on crate67 crate47)
	(at crate68 distributor9)
	(on crate68 crate65)
	(at crate69 depot0)
	(on crate69 crate56)
	(at crate70 distributor7)
	(on crate70 crate46)
	(at crate71 depot7)
	(on crate71 crate49)
	(at crate72 depot4)
	(on crate72 crate44)
	(at crate73 distributor7)
	(on crate73 crate70)
	(at crate74 depot5)
	(on crate74 crate58)
	(at crate75 distributor8)
	(on crate75 crate64)
	(at crate76 distributor2)
	(on crate76 crate57)
	(at crate77 distributor5)
	(on crate77 crate63)
	(at crate78 depot3)
	(on crate78 pallet3)
	(at crate79 depot5)
	(on crate79 crate74)
)

(:goal (and
		(on crate0 crate60)
		(on crate1 crate62)
		(on crate2 crate53)
		(on crate3 pallet13)
		(on crate4 pallet6)
		(on crate5 pallet12)
		(on crate6 crate43)
		(on crate7 crate32)
		(on crate8 crate48)
		(on crate9 crate7)
		(on crate10 crate70)
		(on crate11 pallet19)
		(on crate13 crate37)
		(on crate14 crate30)
		(on crate15 crate46)
		(on crate16 pallet4)
		(on crate17 crate66)
		(on crate18 pallet16)
		(on crate19 crate67)
		(on crate20 pallet1)
		(on crate21 crate38)
		(on crate22 crate5)
		(on crate25 crate35)
		(on crate26 crate8)
		(on crate27 crate9)
		(on crate28 crate44)
		(on crate30 crate25)
		(on crate32 crate3)
		(on crate33 crate10)
		(on crate34 crate72)
		(on crate35 pallet2)
		(on crate36 crate49)
		(on crate37 crate71)
		(on crate38 crate2)
		(on crate39 crate22)
		(on crate40 crate34)
		(on crate41 crate52)
		(on crate42 crate11)
		(on crate43 crate13)
		(on crate44 crate16)
		(on crate45 pallet7)
		(on crate46 pallet14)
		(on crate48 pallet5)
		(on crate49 pallet18)
		(on crate50 crate4)
		(on crate51 crate39)
		(on crate52 crate59)
		(on crate53 pallet15)
		(on crate54 pallet0)
		(on crate57 crate54)
		(on crate58 pallet3)
		(on crate59 crate58)
		(on crate60 crate61)
		(on crate61 pallet11)
		(on crate62 pallet8)
		(on crate63 pallet10)
		(on crate64 pallet9)
		(on crate65 crate20)
		(on crate66 crate65)
		(on crate67 crate28)
		(on crate68 crate21)
		(on crate69 crate27)
		(on crate70 pallet17)
		(on crate71 crate64)
		(on crate72 crate45)
		(on crate73 crate40)
		(on crate74 crate79)
		(on crate75 crate18)
		(on crate76 crate6)
		(on crate79 crate63)
	)
))
