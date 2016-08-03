(define (problem depotprob10) (:domain Depot)
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
	(clear crate43)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate56)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate48)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate21)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate41)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate36)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 depot7)
	(clear crate63)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor0)
	(clear crate62)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor1)
	(clear crate59)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor2)
	(clear crate51)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor3)
	(clear crate54)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor4)
	(clear crate27)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor5)
	(clear crate60)
	(pallet pallet14)
	(surface pallet14)
	(at pallet14 distributor6)
	(clear crate49)
	(pallet pallet15)
	(surface pallet15)
	(at pallet15 distributor7)
	(clear crate47)
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
	(at crate0 depot2)
	(on crate0 pallet2)
	(crate crate1)
	(surface crate1)
	(at crate1 depot4)
	(on crate1 pallet4)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor3)
	(on crate2 pallet11)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor3)
	(on crate3 crate2)
	(crate crate4)
	(surface crate4)
	(at crate4 depot4)
	(on crate4 crate1)
	(crate crate5)
	(surface crate5)
	(at crate5 depot3)
	(on crate5 pallet3)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor0)
	(on crate6 pallet8)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor6)
	(on crate7 pallet14)
	(crate crate8)
	(surface crate8)
	(at crate8 depot1)
	(on crate8 pallet1)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor7)
	(on crate9 pallet15)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor1)
	(on crate10 pallet9)
	(crate crate11)
	(surface crate11)
	(at crate11 depot3)
	(on crate11 crate5)
	(crate crate12)
	(surface crate12)
	(at crate12 depot4)
	(on crate12 crate4)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor7)
	(on crate13 crate9)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor5)
	(on crate14 pallet13)
	(crate crate15)
	(surface crate15)
	(at crate15 depot1)
	(on crate15 crate8)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor5)
	(on crate16 crate14)
	(crate crate17)
	(surface crate17)
	(at crate17 depot7)
	(on crate17 pallet7)
	(crate crate18)
	(surface crate18)
	(at crate18 depot2)
	(on crate18 crate0)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor1)
	(on crate19 crate10)
	(crate crate20)
	(surface crate20)
	(at crate20 depot6)
	(on crate20 pallet6)
	(crate crate21)
	(surface crate21)
	(at crate21 depot4)
	(on crate21 crate12)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor7)
	(on crate22 crate13)
	(crate crate23)
	(surface crate23)
	(at crate23 depot6)
	(on crate23 crate20)
	(crate crate24)
	(surface crate24)
	(at crate24 depot0)
	(on crate24 pallet0)
	(crate crate25)
	(surface crate25)
	(at crate25 distributor4)
	(on crate25 pallet12)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor2)
	(on crate26 pallet10)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor4)
	(on crate27 crate25)
	(crate crate28)
	(surface crate28)
	(at crate28 distributor7)
	(on crate28 crate22)
	(crate crate29)
	(surface crate29)
	(at crate29 depot2)
	(on crate29 crate18)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor1)
	(on crate30 crate19)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor5)
	(on crate31 crate16)
	(crate crate32)
	(surface crate32)
	(at crate32 distributor2)
	(on crate32 crate26)
	(crate crate33)
	(surface crate33)
	(at crate33 depot0)
	(on crate33 crate24)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor0)
	(on crate34 crate6)
	(crate crate35)
	(surface crate35)
	(at crate35 depot3)
	(on crate35 crate11)
	(crate crate36)
	(surface crate36)
	(at crate36 depot6)
	(on crate36 crate23)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor5)
	(on crate37 crate31)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor3)
	(on crate38 crate3)
	(crate crate39)
	(surface crate39)
	(at crate39 depot7)
	(on crate39 crate17)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor1)
	(on crate40 crate30)
	(crate crate41)
	(surface crate41)
	(at crate41 depot5)
	(on crate41 pallet5)
	(crate crate42)
	(surface crate42)
	(at crate42 depot3)
	(on crate42 crate35)
	(crate crate43)
	(surface crate43)
	(at crate43 depot1)
	(on crate43 crate15)
	(crate crate44)
	(surface crate44)
	(at crate44 distributor6)
	(on crate44 crate7)
	(crate crate45)
	(surface crate45)
	(at crate45 depot0)
	(on crate45 crate33)
	(crate crate46)
	(surface crate46)
	(at crate46 depot7)
	(on crate46 crate39)
	(crate crate47)
	(surface crate47)
	(at crate47 distributor7)
	(on crate47 crate28)
	(crate crate48)
	(surface crate48)
	(at crate48 depot3)
	(on crate48 crate42)
	(crate crate49)
	(surface crate49)
	(at crate49 distributor6)
	(on crate49 crate44)
	(crate crate50)
	(surface crate50)
	(at crate50 distributor2)
	(on crate50 crate32)
	(crate crate51)
	(surface crate51)
	(at crate51 distributor2)
	(on crate51 crate50)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor1)
	(on crate52 crate40)
	(crate crate53)
	(surface crate53)
	(at crate53 depot7)
	(on crate53 crate46)
	(crate crate54)
	(surface crate54)
	(at crate54 distributor3)
	(on crate54 crate38)
	(crate crate55)
	(surface crate55)
	(at crate55 depot0)
	(on crate55 crate45)
	(crate crate56)
	(surface crate56)
	(at crate56 depot2)
	(on crate56 crate29)
	(crate crate57)
	(surface crate57)
	(at crate57 depot7)
	(on crate57 crate53)
	(crate crate58)
	(surface crate58)
	(at crate58 distributor1)
	(on crate58 crate52)
	(crate crate59)
	(surface crate59)
	(at crate59 distributor1)
	(on crate59 crate58)
	(crate crate60)
	(surface crate60)
	(at crate60 distributor5)
	(on crate60 crate37)
	(crate crate61)
	(surface crate61)
	(at crate61 depot0)
	(on crate61 crate55)
	(crate crate62)
	(surface crate62)
	(at crate62 distributor0)
	(on crate62 crate34)
	(crate crate63)
	(surface crate63)
	(at crate63 depot7)
	(on crate63 crate57)
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
		(on crate0 crate32)
		(on crate2 pallet8)
		(on crate3 crate52)
		(on crate4 pallet11)
		(on crate5 crate53)
		(on crate6 crate13)
		(on crate8 crate46)
		(on crate9 crate43)
		(on crate10 crate48)
		(on crate11 pallet5)
		(on crate12 pallet14)
		(on crate13 crate56)
		(on crate14 crate2)
		(on crate15 crate6)
		(on crate16 pallet1)
		(on crate17 crate16)
		(on crate18 pallet15)
		(on crate19 crate33)
		(on crate20 crate28)
		(on crate21 crate40)
		(on crate22 crate62)
		(on crate23 crate51)
		(on crate24 pallet7)
		(on crate26 crate47)
		(on crate28 pallet10)
		(on crate29 crate4)
		(on crate31 crate3)
		(on crate32 pallet12)
		(on crate33 crate17)
		(on crate34 pallet4)
		(on crate35 pallet9)
		(on crate38 crate44)
		(on crate39 crate12)
		(on crate40 pallet6)
		(on crate41 crate24)
		(on crate43 crate31)
		(on crate44 crate55)
		(on crate45 pallet0)
		(on crate46 pallet2)
		(on crate47 crate19)
		(on crate48 crate34)
		(on crate49 crate63)
		(on crate50 crate59)
		(on crate51 crate45)
		(on crate52 crate23)
		(on crate53 crate41)
		(on crate54 crate21)
		(on crate55 crate20)
		(on crate56 crate14)
		(on crate57 crate8)
		(on crate58 crate0)
		(on crate59 crate58)
		(on crate60 crate9)
		(on crate61 pallet13)
		(on crate62 pallet3)
		(on crate63 crate61)
	)
))
