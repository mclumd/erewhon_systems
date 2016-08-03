(define (problem depotprob70) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate71)
	(at pallet1 depot1)
	(clear crate29)
	(at pallet2 depot2)
	(clear crate70)
	(at pallet3 depot3)
	(clear crate36)
	(at pallet4 depot4)
	(clear crate65)
	(at pallet5 depot5)
	(clear crate69)
	(at pallet6 depot6)
	(clear crate56)
	(at pallet7 depot7)
	(clear crate63)
	(at pallet8 depot8)
	(clear crate60)
	(at pallet9 distributor0)
	(clear crate64)
	(at pallet10 distributor1)
	(clear crate62)
	(at pallet11 distributor2)
	(clear crate67)
	(at pallet12 distributor3)
	(clear crate54)
	(at pallet13 distributor4)
	(clear crate38)
	(at pallet14 distributor5)
	(clear crate68)
	(at pallet15 distributor6)
	(clear crate49)
	(at pallet16 distributor7)
	(clear crate35)
	(at pallet17 distributor8)
	(clear crate66)
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
	(at crate0 depot7)
	(on crate0 pallet7)
	(at crate1 distributor1)
	(on crate1 pallet10)
	(at crate2 depot6)
	(on crate2 pallet6)
	(at crate3 depot6)
	(on crate3 crate2)
	(at crate4 depot3)
	(on crate4 pallet3)
	(at crate5 distributor2)
	(on crate5 pallet11)
	(at crate6 depot0)
	(on crate6 pallet0)
	(at crate7 distributor1)
	(on crate7 crate1)
	(at crate8 distributor7)
	(on crate8 pallet16)
	(at crate9 distributor7)
	(on crate9 crate8)
	(at crate10 distributor4)
	(on crate10 pallet13)
	(at crate11 depot6)
	(on crate11 crate3)
	(at crate12 distributor3)
	(on crate12 pallet12)
	(at crate13 depot6)
	(on crate13 crate11)
	(at crate14 depot1)
	(on crate14 pallet1)
	(at crate15 distributor3)
	(on crate15 crate12)
	(at crate16 distributor6)
	(on crate16 pallet15)
	(at crate17 distributor1)
	(on crate17 crate7)
	(at crate18 depot5)
	(on crate18 pallet5)
	(at crate19 distributor5)
	(on crate19 pallet14)
	(at crate20 depot8)
	(on crate20 pallet8)
	(at crate21 distributor2)
	(on crate21 crate5)
	(at crate22 distributor2)
	(on crate22 crate21)
	(at crate23 depot7)
	(on crate23 crate0)
	(at crate24 distributor0)
	(on crate24 pallet9)
	(at crate25 distributor7)
	(on crate25 crate9)
	(at crate26 depot0)
	(on crate26 crate6)
	(at crate27 depot3)
	(on crate27 crate4)
	(at crate28 distributor5)
	(on crate28 crate19)
	(at crate29 depot1)
	(on crate29 crate14)
	(at crate30 distributor5)
	(on crate30 crate28)
	(at crate31 depot8)
	(on crate31 crate20)
	(at crate32 depot0)
	(on crate32 crate26)
	(at crate33 distributor7)
	(on crate33 crate25)
	(at crate34 distributor8)
	(on crate34 pallet17)
	(at crate35 distributor7)
	(on crate35 crate33)
	(at crate36 depot3)
	(on crate36 crate27)
	(at crate37 depot0)
	(on crate37 crate32)
	(at crate38 distributor4)
	(on crate38 crate10)
	(at crate39 depot8)
	(on crate39 crate31)
	(at crate40 distributor5)
	(on crate40 crate30)
	(at crate41 distributor0)
	(on crate41 crate24)
	(at crate42 distributor1)
	(on crate42 crate17)
	(at crate43 distributor0)
	(on crate43 crate41)
	(at crate44 depot5)
	(on crate44 crate18)
	(at crate45 depot6)
	(on crate45 crate13)
	(at crate46 depot7)
	(on crate46 crate23)
	(at crate47 distributor5)
	(on crate47 crate40)
	(at crate48 distributor6)
	(on crate48 crate16)
	(at crate49 distributor6)
	(on crate49 crate48)
	(at crate50 depot8)
	(on crate50 crate39)
	(at crate51 depot5)
	(on crate51 crate44)
	(at crate52 depot5)
	(on crate52 crate51)
	(at crate53 distributor0)
	(on crate53 crate43)
	(at crate54 distributor3)
	(on crate54 crate15)
	(at crate55 depot5)
	(on crate55 crate52)
	(at crate56 depot6)
	(on crate56 crate45)
	(at crate57 depot5)
	(on crate57 crate55)
	(at crate58 distributor1)
	(on crate58 crate42)
	(at crate59 depot7)
	(on crate59 crate46)
	(at crate60 depot8)
	(on crate60 crate50)
	(at crate61 distributor8)
	(on crate61 crate34)
	(at crate62 distributor1)
	(on crate62 crate58)
	(at crate63 depot7)
	(on crate63 crate59)
	(at crate64 distributor0)
	(on crate64 crate53)
	(at crate65 depot4)
	(on crate65 pallet4)
	(at crate66 distributor8)
	(on crate66 crate61)
	(at crate67 distributor2)
	(on crate67 crate22)
	(at crate68 distributor5)
	(on crate68 crate47)
	(at crate69 depot5)
	(on crate69 crate57)
	(at crate70 depot2)
	(on crate70 pallet2)
	(at crate71 depot0)
	(on crate71 crate37)
)

(:goal (and
		(on crate0 pallet2)
		(on crate2 crate39)
		(on crate3 crate49)
		(on crate4 crate66)
		(on crate5 pallet6)
		(on crate6 pallet5)
		(on crate7 crate9)
		(on crate8 crate14)
		(on crate9 pallet3)
		(on crate10 pallet16)
		(on crate11 crate26)
		(on crate12 crate6)
		(on crate13 crate47)
		(on crate14 crate41)
		(on crate15 crate44)
		(on crate16 pallet0)
		(on crate17 crate38)
		(on crate18 pallet1)
		(on crate19 crate68)
		(on crate20 crate37)
		(on crate21 crate61)
		(on crate22 pallet8)
		(on crate23 crate7)
		(on crate24 crate71)
		(on crate25 pallet13)
		(on crate26 pallet12)
		(on crate27 crate15)
		(on crate28 crate51)
		(on crate29 crate53)
		(on crate30 crate2)
		(on crate31 crate36)
		(on crate32 crate0)
		(on crate33 crate16)
		(on crate34 crate18)
		(on crate36 pallet7)
		(on crate37 crate31)
		(on crate38 crate22)
		(on crate39 pallet4)
		(on crate40 crate64)
		(on crate41 crate12)
		(on crate42 crate13)
		(on crate43 crate48)
		(on crate44 pallet14)
		(on crate45 crate52)
		(on crate46 crate29)
		(on crate47 pallet11)
		(on crate48 crate69)
		(on crate49 crate54)
		(on crate51 pallet9)
		(on crate52 crate30)
		(on crate53 crate32)
		(on crate54 pallet17)
		(on crate55 crate57)
		(on crate57 crate24)
		(on crate58 crate34)
		(on crate59 crate5)
		(on crate60 pallet10)
		(on crate61 pallet15)
		(on crate62 crate20)
		(on crate63 crate70)
		(on crate64 crate11)
		(on crate66 crate25)
		(on crate68 crate63)
		(on crate69 crate60)
		(on crate70 crate23)
		(on crate71 crate10)
	)
))