(define (problem depotprob130) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate61)
	(at pallet1 depot1)
	(clear crate41)
	(at pallet2 depot2)
	(clear crate38)
	(at pallet3 depot3)
	(clear crate58)
	(at pallet4 depot4)
	(clear crate46)
	(at pallet5 depot5)
	(clear crate63)
	(at pallet6 depot6)
	(clear crate42)
	(at pallet7 depot7)
	(clear crate69)
	(at pallet8 depot8)
	(clear crate48)
	(at pallet9 distributor0)
	(clear crate57)
	(at pallet10 distributor1)
	(clear crate64)
	(at pallet11 distributor2)
	(clear crate40)
	(at pallet12 distributor3)
	(clear crate71)
	(at pallet13 distributor4)
	(clear crate59)
	(at pallet14 distributor5)
	(clear crate50)
	(at pallet15 distributor6)
	(clear crate65)
	(at pallet16 distributor7)
	(clear crate70)
	(at pallet17 distributor8)
	(clear crate34)
	(at truck0 distributor2)
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
	(at crate0 distributor6)
	(on crate0 pallet15)
	(at crate1 distributor6)
	(on crate1 crate0)
	(at crate2 depot7)
	(on crate2 pallet7)
	(at crate3 depot7)
	(on crate3 crate2)
	(at crate4 distributor8)
	(on crate4 pallet17)
	(at crate5 distributor2)
	(on crate5 pallet11)
	(at crate6 depot0)
	(on crate6 pallet0)
	(at crate7 distributor2)
	(on crate7 crate5)
	(at crate8 distributor2)
	(on crate8 crate7)
	(at crate9 distributor6)
	(on crate9 crate1)
	(at crate10 depot0)
	(on crate10 crate6)
	(at crate11 depot8)
	(on crate11 pallet8)
	(at crate12 distributor3)
	(on crate12 pallet12)
	(at crate13 distributor6)
	(on crate13 crate9)
	(at crate14 distributor5)
	(on crate14 pallet14)
	(at crate15 distributor5)
	(on crate15 crate14)
	(at crate16 depot2)
	(on crate16 pallet2)
	(at crate17 distributor3)
	(on crate17 crate12)
	(at crate18 distributor1)
	(on crate18 pallet10)
	(at crate19 depot6)
	(on crate19 pallet6)
	(at crate20 distributor3)
	(on crate20 crate17)
	(at crate21 depot3)
	(on crate21 pallet3)
	(at crate22 depot2)
	(on crate22 crate16)
	(at crate23 depot3)
	(on crate23 crate21)
	(at crate24 depot8)
	(on crate24 crate11)
	(at crate25 distributor4)
	(on crate25 pallet13)
	(at crate26 depot0)
	(on crate26 crate10)
	(at crate27 depot2)
	(on crate27 crate22)
	(at crate28 distributor2)
	(on crate28 crate8)
	(at crate29 depot8)
	(on crate29 crate24)
	(at crate30 depot7)
	(on crate30 crate3)
	(at crate31 depot2)
	(on crate31 crate27)
	(at crate32 distributor8)
	(on crate32 crate4)
	(at crate33 depot2)
	(on crate33 crate31)
	(at crate34 distributor8)
	(on crate34 crate32)
	(at crate35 depot2)
	(on crate35 crate33)
	(at crate36 depot8)
	(on crate36 crate29)
	(at crate37 depot7)
	(on crate37 crate30)
	(at crate38 depot2)
	(on crate38 crate35)
	(at crate39 depot6)
	(on crate39 crate19)
	(at crate40 distributor2)
	(on crate40 crate28)
	(at crate41 depot1)
	(on crate41 pallet1)
	(at crate42 depot6)
	(on crate42 crate39)
	(at crate43 depot7)
	(on crate43 crate37)
	(at crate44 depot3)
	(on crate44 crate23)
	(at crate45 depot8)
	(on crate45 crate36)
	(at crate46 depot4)
	(on crate46 pallet4)
	(at crate47 depot3)
	(on crate47 crate44)
	(at crate48 depot8)
	(on crate48 crate45)
	(at crate49 distributor4)
	(on crate49 crate25)
	(at crate50 distributor5)
	(on crate50 crate15)
	(at crate51 depot3)
	(on crate51 crate47)
	(at crate52 depot3)
	(on crate52 crate51)
	(at crate53 distributor7)
	(on crate53 pallet16)
	(at crate54 depot3)
	(on crate54 crate52)
	(at crate55 distributor7)
	(on crate55 crate53)
	(at crate56 depot7)
	(on crate56 crate43)
	(at crate57 distributor0)
	(on crate57 pallet9)
	(at crate58 depot3)
	(on crate58 crate54)
	(at crate59 distributor4)
	(on crate59 crate49)
	(at crate60 distributor6)
	(on crate60 crate13)
	(at crate61 depot0)
	(on crate61 crate26)
	(at crate62 distributor7)
	(on crate62 crate55)
	(at crate63 depot5)
	(on crate63 pallet5)
	(at crate64 distributor1)
	(on crate64 crate18)
	(at crate65 distributor6)
	(on crate65 crate60)
	(at crate66 distributor7)
	(on crate66 crate62)
	(at crate67 distributor3)
	(on crate67 crate20)
	(at crate68 distributor3)
	(on crate68 crate67)
	(at crate69 depot7)
	(on crate69 crate56)
	(at crate70 distributor7)
	(on crate70 crate66)
	(at crate71 distributor3)
	(on crate71 crate68)
)

(:goal (and
		(on crate0 crate63)
		(on crate1 crate65)
		(on crate2 crate41)
		(on crate3 crate16)
		(on crate4 crate52)
		(on crate5 pallet5)
		(on crate6 pallet4)
		(on crate7 pallet1)
		(on crate8 crate67)
		(on crate9 crate12)
		(on crate10 crate54)
		(on crate11 crate2)
		(on crate12 pallet11)
		(on crate13 crate25)
		(on crate14 crate39)
		(on crate15 crate55)
		(on crate16 pallet2)
		(on crate17 crate26)
		(on crate18 crate6)
		(on crate19 crate14)
		(on crate20 crate37)
		(on crate21 pallet0)
		(on crate23 crate28)
		(on crate24 crate5)
		(on crate25 crate7)
		(on crate26 crate8)
		(on crate27 pallet6)
		(on crate28 pallet8)
		(on crate30 pallet13)
		(on crate31 crate32)
		(on crate32 crate59)
		(on crate33 crate64)
		(on crate35 crate38)
		(on crate37 crate9)
		(on crate38 crate33)
		(on crate39 crate45)
		(on crate40 crate66)
		(on crate41 pallet3)
		(on crate42 pallet12)
		(on crate44 pallet14)
		(on crate45 pallet15)
		(on crate47 crate69)
		(on crate48 crate27)
		(on crate49 crate4)
		(on crate51 crate40)
		(on crate52 crate23)
		(on crate54 crate35)
		(on crate55 crate30)
		(on crate56 crate48)
		(on crate57 crate24)
		(on crate58 crate68)
		(on crate59 crate11)
		(on crate60 crate44)
		(on crate61 crate0)
		(on crate62 crate18)
		(on crate63 pallet7)
		(on crate64 crate3)
		(on crate65 crate56)
		(on crate66 crate57)
		(on crate67 pallet17)
		(on crate68 pallet10)
		(on crate69 pallet9)
		(on crate70 crate58)
	)
))