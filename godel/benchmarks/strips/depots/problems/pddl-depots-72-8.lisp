(define (problem depotprob80) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate60)
	(at pallet1 depot1)
	(clear crate54)
	(at pallet2 depot2)
	(clear crate51)
	(at pallet3 depot3)
	(clear crate58)
	(at pallet4 depot4)
	(clear crate20)
	(at pallet5 depot5)
	(clear crate66)
	(at pallet6 depot6)
	(clear crate71)
	(at pallet7 depot7)
	(clear crate55)
	(at pallet8 depot8)
	(clear crate67)
	(at pallet9 distributor0)
	(clear crate70)
	(at pallet10 distributor1)
	(clear crate63)
	(at pallet11 distributor2)
	(clear crate37)
	(at pallet12 distributor3)
	(clear crate68)
	(at pallet13 distributor4)
	(clear crate53)
	(at pallet14 distributor5)
	(clear crate32)
	(at pallet15 distributor6)
	(clear crate65)
	(at pallet16 distributor7)
	(clear crate47)
	(at pallet17 distributor8)
	(clear crate45)
	(at truck0 depot1)
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
	(at crate0 distributor4)
	(on crate0 pallet13)
	(at crate1 depot4)
	(on crate1 pallet4)
	(at crate2 distributor7)
	(on crate2 pallet16)
	(at crate3 depot4)
	(on crate3 crate1)
	(at crate4 depot3)
	(on crate4 pallet3)
	(at crate5 distributor2)
	(on crate5 pallet11)
	(at crate6 distributor8)
	(on crate6 pallet17)
	(at crate7 distributor0)
	(on crate7 pallet9)
	(at crate8 distributor0)
	(on crate8 crate7)
	(at crate9 depot6)
	(on crate9 pallet6)
	(at crate10 distributor1)
	(on crate10 pallet10)
	(at crate11 distributor4)
	(on crate11 crate0)
	(at crate12 distributor5)
	(on crate12 pallet14)
	(at crate13 depot5)
	(on crate13 pallet5)
	(at crate14 distributor3)
	(on crate14 pallet12)
	(at crate15 depot8)
	(on crate15 pallet8)
	(at crate16 distributor2)
	(on crate16 crate5)
	(at crate17 depot7)
	(on crate17 pallet7)
	(at crate18 distributor7)
	(on crate18 crate2)
	(at crate19 distributor6)
	(on crate19 pallet15)
	(at crate20 depot4)
	(on crate20 crate3)
	(at crate21 depot6)
	(on crate21 crate9)
	(at crate22 distributor4)
	(on crate22 crate11)
	(at crate23 distributor4)
	(on crate23 crate22)
	(at crate24 distributor0)
	(on crate24 crate8)
	(at crate25 depot0)
	(on crate25 pallet0)
	(at crate26 distributor8)
	(on crate26 crate6)
	(at crate27 depot1)
	(on crate27 pallet1)
	(at crate28 distributor8)
	(on crate28 crate26)
	(at crate29 distributor1)
	(on crate29 crate10)
	(at crate30 distributor8)
	(on crate30 crate28)
	(at crate31 depot1)
	(on crate31 crate27)
	(at crate32 distributor5)
	(on crate32 crate12)
	(at crate33 depot2)
	(on crate33 pallet2)
	(at crate34 depot2)
	(on crate34 crate33)
	(at crate35 distributor6)
	(on crate35 crate19)
	(at crate36 depot8)
	(on crate36 crate15)
	(at crate37 distributor2)
	(on crate37 crate16)
	(at crate38 depot2)
	(on crate38 crate34)
	(at crate39 distributor0)
	(on crate39 crate24)
	(at crate40 depot8)
	(on crate40 crate36)
	(at crate41 distributor6)
	(on crate41 crate35)
	(at crate42 depot6)
	(on crate42 crate21)
	(at crate43 depot3)
	(on crate43 crate4)
	(at crate44 depot6)
	(on crate44 crate42)
	(at crate45 distributor8)
	(on crate45 crate30)
	(at crate46 distributor6)
	(on crate46 crate41)
	(at crate47 distributor7)
	(on crate47 crate18)
	(at crate48 distributor1)
	(on crate48 crate29)
	(at crate49 depot7)
	(on crate49 crate17)
	(at crate50 depot1)
	(on crate50 crate31)
	(at crate51 depot2)
	(on crate51 crate38)
	(at crate52 distributor0)
	(on crate52 crate39)
	(at crate53 distributor4)
	(on crate53 crate23)
	(at crate54 depot1)
	(on crate54 crate50)
	(at crate55 depot7)
	(on crate55 crate49)
	(at crate56 distributor6)
	(on crate56 crate46)
	(at crate57 depot0)
	(on crate57 crate25)
	(at crate58 depot3)
	(on crate58 crate43)
	(at crate59 distributor1)
	(on crate59 crate48)
	(at crate60 depot0)
	(on crate60 crate57)
	(at crate61 distributor6)
	(on crate61 crate56)
	(at crate62 distributor1)
	(on crate62 crate59)
	(at crate63 distributor1)
	(on crate63 crate62)
	(at crate64 distributor6)
	(on crate64 crate61)
	(at crate65 distributor6)
	(on crate65 crate64)
	(at crate66 depot5)
	(on crate66 crate13)
	(at crate67 depot8)
	(on crate67 crate40)
	(at crate68 distributor3)
	(on crate68 crate14)
	(at crate69 distributor0)
	(on crate69 crate52)
	(at crate70 distributor0)
	(on crate70 crate69)
	(at crate71 depot6)
	(on crate71 crate44)
)

(:goal (and
		(on crate1 crate10)
		(on crate2 crate11)
		(on crate3 pallet16)
		(on crate4 crate38)
		(on crate5 crate46)
		(on crate6 crate48)
		(on crate8 crate71)
		(on crate9 pallet8)
		(on crate10 crate43)
		(on crate11 pallet0)
		(on crate13 crate3)
		(on crate15 crate35)
		(on crate16 pallet15)
		(on crate19 crate54)
		(on crate20 crate50)
		(on crate21 pallet7)
		(on crate22 pallet3)
		(on crate23 crate52)
		(on crate24 crate57)
		(on crate25 pallet11)
		(on crate26 crate60)
		(on crate27 pallet12)
		(on crate28 crate31)
		(on crate29 crate9)
		(on crate30 pallet4)
		(on crate31 pallet2)
		(on crate32 pallet5)
		(on crate33 crate69)
		(on crate34 crate51)
		(on crate35 pallet6)
		(on crate36 pallet17)
		(on crate37 pallet14)
		(on crate38 crate45)
		(on crate39 crate33)
		(on crate40 crate5)
		(on crate41 crate39)
		(on crate42 crate49)
		(on crate43 crate16)
		(on crate44 crate40)
		(on crate45 pallet13)
		(on crate46 crate1)
		(on crate47 crate65)
		(on crate48 crate66)
		(on crate49 crate13)
		(on crate50 crate24)
		(on crate51 crate30)
		(on crate52 pallet9)
		(on crate54 crate28)
		(on crate55 crate22)
		(on crate56 crate25)
		(on crate57 crate27)
		(on crate58 crate67)
		(on crate59 crate32)
		(on crate60 crate56)
		(on crate61 pallet10)
		(on crate63 crate59)
		(on crate65 crate36)
		(on crate66 crate4)
		(on crate67 crate23)
		(on crate69 crate19)
		(on crate70 crate63)
		(on crate71 pallet1)
	)
))