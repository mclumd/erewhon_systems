(define (problem depotprob230) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate21)
	(at pallet1 depot1)
	(clear crate64)
	(at pallet2 depot2)
	(clear crate60)
	(at pallet3 depot3)
	(clear crate67)
	(at pallet4 depot4)
	(clear crate19)
	(at pallet5 depot5)
	(clear crate53)
	(at pallet6 depot6)
	(clear crate71)
	(at pallet7 depot7)
	(clear crate41)
	(at pallet8 depot8)
	(clear crate25)
	(at pallet9 distributor0)
	(clear crate39)
	(at pallet10 distributor1)
	(clear crate29)
	(at pallet11 distributor2)
	(clear crate62)
	(at pallet12 distributor3)
	(clear crate69)
	(at pallet13 distributor4)
	(clear crate59)
	(at pallet14 distributor5)
	(clear crate54)
	(at pallet15 distributor6)
	(clear crate68)
	(at pallet16 distributor7)
	(clear crate66)
	(at pallet17 distributor8)
	(clear crate52)
	(at truck0 distributor1)
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
	(at hoist9 distributor0)
	(available hoist9)
	(at hoist10 distributor1)
	(available hoist10)
	(at hoist11 distributor2)
	(available hoist11)
	(at hoist12 distributor3)
	(available hoist12)
	(at hoist13 distributor4)
	(available hoist13)
	(at hoist14 distributor5)
	(available hoist14)
	(at hoist15 distributor6)
	(available hoist15)
	(at hoist16 distributor7)
	(available hoist16)
	(at hoist17 distributor8)
	(available hoist17)
	(at crate0 distributor7)
	(on crate0 pallet16)
	(at crate1 distributor0)
	(on crate1 pallet9)
	(at crate2 distributor4)
	(on crate2 pallet13)
	(at crate3 distributor7)
	(on crate3 crate0)
	(at crate4 distributor6)
	(on crate4 pallet15)
	(at crate5 distributor5)
	(on crate5 pallet14)
	(at crate6 depot3)
	(on crate6 pallet3)
	(at crate7 depot3)
	(on crate7 crate6)
	(at crate8 depot5)
	(on crate8 pallet5)
	(at crate9 distributor7)
	(on crate9 crate3)
	(at crate10 depot8)
	(on crate10 pallet8)
	(at crate11 depot4)
	(on crate11 pallet4)
	(at crate12 distributor8)
	(on crate12 pallet17)
	(at crate13 distributor2)
	(on crate13 pallet11)
	(at crate14 distributor8)
	(on crate14 crate12)
	(at crate15 distributor5)
	(on crate15 crate5)
	(at crate16 distributor0)
	(on crate16 crate1)
	(at crate17 distributor3)
	(on crate17 pallet12)
	(at crate18 distributor0)
	(on crate18 crate16)
	(at crate19 depot4)
	(on crate19 crate11)
	(at crate20 depot1)
	(on crate20 pallet1)
	(at crate21 depot0)
	(on crate21 pallet0)
	(at crate22 distributor5)
	(on crate22 crate15)
	(at crate23 depot1)
	(on crate23 crate20)
	(at crate24 depot1)
	(on crate24 crate23)
	(at crate25 depot8)
	(on crate25 crate10)
	(at crate26 depot1)
	(on crate26 crate24)
	(at crate27 depot6)
	(on crate27 pallet6)
	(at crate28 depot5)
	(on crate28 crate8)
	(at crate29 distributor1)
	(on crate29 pallet10)
	(at crate30 distributor0)
	(on crate30 crate18)
	(at crate31 depot2)
	(on crate31 pallet2)
	(at crate32 distributor3)
	(on crate32 crate17)
	(at crate33 depot5)
	(on crate33 crate28)
	(at crate34 depot7)
	(on crate34 pallet7)
	(at crate35 distributor0)
	(on crate35 crate30)
	(at crate36 distributor2)
	(on crate36 crate13)
	(at crate37 distributor4)
	(on crate37 crate2)
	(at crate38 distributor5)
	(on crate38 crate22)
	(at crate39 distributor0)
	(on crate39 crate35)
	(at crate40 distributor6)
	(on crate40 crate4)
	(at crate41 depot7)
	(on crate41 crate34)
	(at crate42 distributor4)
	(on crate42 crate37)
	(at crate43 distributor8)
	(on crate43 crate14)
	(at crate44 distributor5)
	(on crate44 crate38)
	(at crate45 depot6)
	(on crate45 crate27)
	(at crate46 distributor7)
	(on crate46 crate9)
	(at crate47 depot6)
	(on crate47 crate45)
	(at crate48 depot5)
	(on crate48 crate33)
	(at crate49 distributor5)
	(on crate49 crate44)
	(at crate50 depot3)
	(on crate50 crate7)
	(at crate51 depot3)
	(on crate51 crate50)
	(at crate52 distributor8)
	(on crate52 crate43)
	(at crate53 depot5)
	(on crate53 crate48)
	(at crate54 distributor5)
	(on crate54 crate49)
	(at crate55 distributor3)
	(on crate55 crate32)
	(at crate56 distributor7)
	(on crate56 crate46)
	(at crate57 distributor2)
	(on crate57 crate36)
	(at crate58 distributor7)
	(on crate58 crate56)
	(at crate59 distributor4)
	(on crate59 crate42)
	(at crate60 depot2)
	(on crate60 crate31)
	(at crate61 depot1)
	(on crate61 crate26)
	(at crate62 distributor2)
	(on crate62 crate57)
	(at crate63 distributor3)
	(on crate63 crate55)
	(at crate64 depot1)
	(on crate64 crate61)
	(at crate65 distributor3)
	(on crate65 crate63)
	(at crate66 distributor7)
	(on crate66 crate58)
	(at crate67 depot3)
	(on crate67 crate51)
	(at crate68 distributor6)
	(on crate68 crate40)
	(at crate69 distributor3)
	(on crate69 crate65)
	(at crate70 depot6)
	(on crate70 crate47)
	(at crate71 depot6)
	(on crate71 crate70)
)

(:goal (and
		(on crate0 crate36)
		(on crate1 crate69)
		(on crate2 pallet15)
		(on crate3 crate56)
		(on crate5 crate71)
		(on crate6 crate63)
		(on crate8 crate10)
		(on crate9 crate20)
		(on crate10 crate13)
		(on crate11 crate70)
		(on crate12 pallet11)
		(on crate13 pallet7)
		(on crate14 pallet17)
		(on crate15 crate62)
		(on crate16 crate12)
		(on crate17 pallet9)
		(on crate18 crate66)
		(on crate19 crate18)
		(on crate20 crate49)
		(on crate21 pallet3)
		(on crate22 pallet14)
		(on crate23 crate31)
		(on crate24 crate5)
		(on crate25 crate52)
		(on crate26 crate48)
		(on crate28 pallet8)
		(on crate29 crate11)
		(on crate30 crate25)
		(on crate31 crate51)
		(on crate32 crate61)
		(on crate33 crate22)
		(on crate34 pallet5)
		(on crate35 pallet10)
		(on crate36 crate46)
		(on crate41 crate68)
		(on crate42 pallet1)
		(on crate43 crate9)
		(on crate44 crate41)
		(on crate45 pallet4)
		(on crate46 crate14)
		(on crate47 crate59)
		(on crate48 crate29)
		(on crate49 crate34)
		(on crate51 crate54)
		(on crate52 pallet13)
		(on crate54 crate55)
		(on crate55 crate65)
		(on crate56 crate67)
		(on crate57 pallet12)
		(on crate58 crate21)
		(on crate59 crate17)
		(on crate60 crate2)
		(on crate61 pallet0)
		(on crate62 pallet6)
		(on crate63 crate28)
		(on crate64 crate42)
		(on crate65 crate47)
		(on crate66 crate57)
		(on crate67 crate44)
		(on crate68 crate1)
		(on crate69 crate45)
		(on crate70 pallet16)
		(on crate71 crate43)
	)
))
