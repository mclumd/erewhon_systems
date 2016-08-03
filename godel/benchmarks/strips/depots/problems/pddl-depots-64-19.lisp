(define (problem depotprob190) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate52)
	(at pallet1 depot1)
	(clear pallet1)
	(at pallet2 depot2)
	(clear crate55)
	(at pallet3 depot3)
	(clear crate57)
	(at pallet4 depot4)
	(clear crate18)
	(at pallet5 depot5)
	(clear crate56)
	(at pallet6 depot6)
	(clear crate63)
	(at pallet7 depot7)
	(clear crate24)
	(at pallet8 distributor0)
	(clear crate49)
	(at pallet9 distributor1)
	(clear crate62)
	(at pallet10 distributor2)
	(clear crate47)
	(at pallet11 distributor3)
	(clear crate36)
	(at pallet12 distributor4)
	(clear crate61)
	(at pallet13 distributor5)
	(clear crate60)
	(at pallet14 distributor6)
	(clear crate29)
	(at pallet15 distributor7)
	(clear crate48)
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
	(at crate0 depot4)
	(on crate0 pallet4)
	(at crate1 depot3)
	(on crate1 pallet3)
	(at crate2 distributor2)
	(on crate2 pallet10)
	(at crate3 distributor4)
	(on crate3 pallet12)
	(at crate4 distributor5)
	(on crate4 pallet13)
	(at crate5 distributor4)
	(on crate5 crate3)
	(at crate6 distributor5)
	(on crate6 crate4)
	(at crate7 depot4)
	(on crate7 crate0)
	(at crate8 distributor1)
	(on crate8 pallet9)
	(at crate9 depot7)
	(on crate9 pallet7)
	(at crate10 depot7)
	(on crate10 crate9)
	(at crate11 distributor1)
	(on crate11 crate8)
	(at crate12 distributor2)
	(on crate12 crate2)
	(at crate13 depot6)
	(on crate13 pallet6)
	(at crate14 depot0)
	(on crate14 pallet0)
	(at crate15 distributor4)
	(on crate15 crate5)
	(at crate16 depot3)
	(on crate16 crate1)
	(at crate17 depot5)
	(on crate17 pallet5)
	(at crate18 depot4)
	(on crate18 crate7)
	(at crate19 distributor2)
	(on crate19 crate12)
	(at crate20 depot2)
	(on crate20 pallet2)
	(at crate21 distributor0)
	(on crate21 pallet8)
	(at crate22 depot2)
	(on crate22 crate20)
	(at crate23 depot2)
	(on crate23 crate22)
	(at crate24 depot7)
	(on crate24 crate10)
	(at crate25 distributor6)
	(on crate25 pallet14)
	(at crate26 depot3)
	(on crate26 crate16)
	(at crate27 depot0)
	(on crate27 crate14)
	(at crate28 distributor0)
	(on crate28 crate21)
	(at crate29 distributor6)
	(on crate29 crate25)
	(at crate30 distributor1)
	(on crate30 crate11)
	(at crate31 distributor5)
	(on crate31 crate6)
	(at crate32 distributor2)
	(on crate32 crate19)
	(at crate33 distributor2)
	(on crate33 crate32)
	(at crate34 depot3)
	(on crate34 crate26)
	(at crate35 depot0)
	(on crate35 crate27)
	(at crate36 distributor3)
	(on crate36 pallet11)
	(at crate37 depot6)
	(on crate37 crate13)
	(at crate38 depot5)
	(on crate38 crate17)
	(at crate39 distributor2)
	(on crate39 crate33)
	(at crate40 depot3)
	(on crate40 crate34)
	(at crate41 distributor4)
	(on crate41 crate15)
	(at crate42 distributor7)
	(on crate42 pallet15)
	(at crate43 depot5)
	(on crate43 crate38)
	(at crate44 depot3)
	(on crate44 crate40)
	(at crate45 depot0)
	(on crate45 crate35)
	(at crate46 distributor7)
	(on crate46 crate42)
	(at crate47 distributor2)
	(on crate47 crate39)
	(at crate48 distributor7)
	(on crate48 crate46)
	(at crate49 distributor0)
	(on crate49 crate28)
	(at crate50 distributor1)
	(on crate50 crate30)
	(at crate51 distributor1)
	(on crate51 crate50)
	(at crate52 depot0)
	(on crate52 crate45)
	(at crate53 depot2)
	(on crate53 crate23)
	(at crate54 distributor1)
	(on crate54 crate51)
	(at crate55 depot2)
	(on crate55 crate53)
	(at crate56 depot5)
	(on crate56 crate43)
	(at crate57 depot3)
	(on crate57 crate44)
	(at crate58 distributor4)
	(on crate58 crate41)
	(at crate59 distributor4)
	(on crate59 crate58)
	(at crate60 distributor5)
	(on crate60 crate31)
	(at crate61 distributor4)
	(on crate61 crate59)
	(at crate62 distributor1)
	(on crate62 crate54)
	(at crate63 depot6)
	(on crate63 crate37)
)

(:goal (and
		(on crate0 crate35)
		(on crate1 crate37)
		(on crate2 crate38)
		(on crate3 crate1)
		(on crate4 crate50)
		(on crate5 pallet8)
		(on crate8 pallet1)
		(on crate9 crate29)
		(on crate10 crate11)
		(on crate11 crate3)
		(on crate12 crate31)
		(on crate14 crate57)
		(on crate15 crate60)
		(on crate16 crate54)
		(on crate18 crate39)
		(on crate19 pallet6)
		(on crate20 crate41)
		(on crate21 pallet2)
		(on crate22 crate55)
		(on crate23 crate42)
		(on crate24 crate59)
		(on crate25 pallet9)
		(on crate26 crate10)
		(on crate27 crate22)
		(on crate29 crate19)
		(on crate31 crate21)
		(on crate33 crate14)
		(on crate34 crate16)
		(on crate35 crate52)
		(on crate36 crate4)
		(on crate37 pallet11)
		(on crate38 pallet14)
		(on crate39 crate46)
		(on crate40 pallet3)
		(on crate41 pallet5)
		(on crate42 crate47)
		(on crate43 crate53)
		(on crate44 crate24)
		(on crate45 crate62)
		(on crate46 crate61)
		(on crate47 crate2)
		(on crate48 crate0)
		(on crate50 pallet13)
		(on crate52 crate18)
		(on crate53 crate33)
		(on crate54 pallet7)
		(on crate55 crate63)
		(on crate56 crate34)
		(on crate57 pallet10)
		(on crate58 pallet12)
		(on crate59 pallet0)
		(on crate60 pallet15)
		(on crate61 crate25)
		(on crate62 crate40)
		(on crate63 pallet4)
	)
))