(define (problem depotprob230) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate61)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate63)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate44)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate48)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate56)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate45)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear pallet6)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 depot7)
	(clear crate62)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor0)
	(clear crate55)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor1)
	(clear crate35)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor2)
	(clear crate54)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor3)
	(clear crate14)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor4)
	(clear crate59)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor5)
	(clear crate42)
	(pallet pallet14)
	(surface pallet14)
	(at pallet14 distributor6)
	(clear crate46)
	(pallet pallet15)
	(surface pallet15)
	(at pallet15 distributor7)
	(clear crate51)
	(truck truck0)
	(at truck0 distributor5)
	(hoist hoist0)
	(at hoist0 depot0)
	(available hoist0)
	(hoist hoist1)
	(at hoist1 depot1)
	(available hoist1)
	(hoist hoist2)
	(at hoist2 depot2)
	(available hoist2)
	(hoist hoist3)
	(at hoist3 depot3)
	(available hoist3)
	(hoist hoist4)
	(at hoist4 depot4)
	(available hoist4)
	(hoist hoist5)
	(at hoist5 depot5)
	(available hoist5)
	(hoist hoist6)
	(at hoist6 depot6)
	(available hoist6)
	(hoist hoist7)
	(at hoist7 depot7)
	(available hoist7)
	(hoist hoist8)
	(at hoist8 distributor0)
	(available hoist8)
	(hoist hoist9)
	(at hoist9 distributor1)
	(available hoist9)
	(hoist hoist10)
	(at hoist10 distributor2)
	(available hoist10)
	(hoist hoist11)
	(at hoist11 distributor3)
	(available hoist11)
	(hoist hoist12)
	(at hoist12 distributor4)
	(available hoist12)
	(hoist hoist13)
	(at hoist13 distributor5)
	(available hoist13)
	(hoist hoist14)
	(at hoist14 distributor6)
	(available hoist14)
	(hoist hoist15)
	(at hoist15 distributor7)
	(available hoist15)
	(crate crate0)
	(surface crate0)
	(at crate0 distributor3)
	(on crate0 pallet11)
	(crate crate1)
	(surface crate1)
	(at crate1 distributor1)
	(on crate1 pallet9)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor3)
	(on crate2 crate0)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor3)
	(on crate3 crate2)
	(crate crate4)
	(surface crate4)
	(at crate4 distributor6)
	(on crate4 pallet14)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor1)
	(on crate5 crate1)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor0)
	(on crate6 pallet8)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor3)
	(on crate7 crate3)
	(crate crate8)
	(surface crate8)
	(at crate8 distributor1)
	(on crate8 crate5)
	(crate crate9)
	(surface crate9)
	(at crate9 depot2)
	(on crate9 pallet2)
	(crate crate10)
	(surface crate10)
	(at crate10 depot0)
	(on crate10 pallet0)
	(crate crate11)
	(surface crate11)
	(at crate11 distributor0)
	(on crate11 crate6)
	(crate crate12)
	(surface crate12)
	(at crate12 depot2)
	(on crate12 crate9)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor1)
	(on crate13 crate8)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor3)
	(on crate14 crate7)
	(crate crate15)
	(surface crate15)
	(at crate15 depot7)
	(on crate15 pallet7)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor7)
	(on crate16 pallet15)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor4)
	(on crate17 pallet12)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor4)
	(on crate18 crate17)
	(crate crate19)
	(surface crate19)
	(at crate19 depot7)
	(on crate19 crate15)
	(crate crate20)
	(surface crate20)
	(at crate20 distributor7)
	(on crate20 crate16)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor1)
	(on crate21 crate13)
	(crate crate22)
	(surface crate22)
	(at crate22 depot2)
	(on crate22 crate12)
	(crate crate23)
	(surface crate23)
	(at crate23 distributor6)
	(on crate23 crate4)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor2)
	(on crate24 pallet10)
	(crate crate25)
	(surface crate25)
	(at crate25 depot4)
	(on crate25 pallet4)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor1)
	(on crate26 crate21)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor5)
	(on crate27 pallet13)
	(crate crate28)
	(surface crate28)
	(at crate28 distributor6)
	(on crate28 crate23)
	(crate crate29)
	(surface crate29)
	(at crate29 distributor1)
	(on crate29 crate26)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor2)
	(on crate30 crate24)
	(crate crate31)
	(surface crate31)
	(at crate31 depot1)
	(on crate31 pallet1)
	(crate crate32)
	(surface crate32)
	(at crate32 depot2)
	(on crate32 crate22)
	(crate crate33)
	(surface crate33)
	(at crate33 depot5)
	(on crate33 pallet5)
	(crate crate34)
	(surface crate34)
	(at crate34 depot5)
	(on crate34 crate33)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor1)
	(on crate35 crate29)
	(crate crate36)
	(surface crate36)
	(at crate36 distributor5)
	(on crate36 crate27)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor6)
	(on crate37 crate28)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor0)
	(on crate38 crate11)
	(crate crate39)
	(surface crate39)
	(at crate39 distributor4)
	(on crate39 crate18)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor6)
	(on crate40 crate37)
	(crate crate41)
	(surface crate41)
	(at crate41 distributor5)
	(on crate41 crate36)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor5)
	(on crate42 crate41)
	(crate crate43)
	(surface crate43)
	(at crate43 depot3)
	(on crate43 pallet3)
	(crate crate44)
	(surface crate44)
	(at crate44 depot2)
	(on crate44 crate32)
	(crate crate45)
	(surface crate45)
	(at crate45 depot5)
	(on crate45 crate34)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor6)
	(on crate46 crate40)
	(crate crate47)
	(surface crate47)
	(at crate47 depot7)
	(on crate47 crate19)
	(crate crate48)
	(surface crate48)
	(at crate48 depot3)
	(on crate48 crate43)
	(crate crate49)
	(surface crate49)
	(at crate49 distributor7)
	(on crate49 crate20)
	(crate crate50)
	(surface crate50)
	(at crate50 distributor2)
	(on crate50 crate30)
	(crate crate51)
	(surface crate51)
	(at crate51 distributor7)
	(on crate51 crate49)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor4)
	(on crate52 crate39)
	(crate crate53)
	(surface crate53)
	(at crate53 distributor0)
	(on crate53 crate38)
	(crate crate54)
	(surface crate54)
	(at crate54 distributor2)
	(on crate54 crate50)
	(crate crate55)
	(surface crate55)
	(at crate55 distributor0)
	(on crate55 crate53)
	(crate crate56)
	(surface crate56)
	(at crate56 depot4)
	(on crate56 crate25)
	(crate crate57)
	(surface crate57)
	(at crate57 depot1)
	(on crate57 crate31)
	(crate crate58)
	(surface crate58)
	(at crate58 depot0)
	(on crate58 crate10)
	(crate crate59)
	(surface crate59)
	(at crate59 distributor4)
	(on crate59 crate52)
	(crate crate60)
	(surface crate60)
	(at crate60 depot1)
	(on crate60 crate57)
	(crate crate61)
	(surface crate61)
	(at crate61 depot0)
	(on crate61 crate58)
	(crate crate62)
	(surface crate62)
	(at crate62 depot7)
	(on crate62 crate47)
	(crate crate63)
	(surface crate63)
	(at crate63 depot1)
	(on crate63 crate60)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place depot5)
	(place depot6)
	(place depot7)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
	(place distributor5)
	(place distributor6)
	(place distributor7)
)

(:goal (and
		(on crate1 crate46)
		(on crate2 pallet6)
		(on crate4 crate59)
		(on crate5 crate53)
		(on crate6 crate25)
		(on crate8 pallet0)
		(on crate9 pallet1)
		(on crate10 crate44)
		(on crate11 crate28)
		(on crate12 crate5)
		(on crate13 crate2)
		(on crate14 crate11)
		(on crate15 crate6)
		(on crate16 crate63)
		(on crate17 crate61)
		(on crate18 pallet3)
		(on crate19 crate12)
		(on crate20 crate60)
		(on crate21 crate57)
		(on crate22 crate56)
		(on crate23 crate20)
		(on crate25 pallet8)
		(on crate26 crate39)
		(on crate27 crate23)
		(on crate28 crate40)
		(on crate29 crate48)
		(on crate30 crate47)
		(on crate31 crate4)
		(on crate32 crate34)
		(on crate33 crate1)
		(on crate34 crate33)
		(on crate35 pallet7)
		(on crate36 crate17)
		(on crate37 pallet4)
		(on crate39 crate32)
		(on crate40 pallet10)
		(on crate41 pallet9)
		(on crate42 crate15)
		(on crate43 crate37)
		(on crate44 crate21)
		(on crate45 pallet13)
		(on crate46 pallet5)
		(on crate47 pallet11)
		(on crate48 crate35)
		(on crate50 pallet15)
		(on crate51 crate54)
		(on crate52 crate19)
		(on crate53 crate45)
		(on crate54 crate8)
		(on crate55 crate26)
		(on crate56 pallet2)
		(on crate57 pallet14)
		(on crate58 crate30)
		(on crate59 crate41)
		(on crate60 pallet12)
		(on crate61 crate43)
		(on crate63 crate50)
	)
))
