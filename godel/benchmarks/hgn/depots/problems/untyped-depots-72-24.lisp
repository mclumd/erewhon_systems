(define (problem depotprob240) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate60)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate61)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate71)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate38)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate18)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate63)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate54)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 depot7)
	(clear crate68)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 depot8)
	(clear crate67)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor0)
	(clear crate58)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor1)
	(clear crate59)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor2)
	(clear crate70)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor3)
	(clear crate37)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor4)
	(clear crate69)
	(pallet pallet14)
	(surface pallet14)
	(at pallet14 distributor5)
	(clear crate28)
	(pallet pallet15)
	(surface pallet15)
	(at pallet15 distributor6)
	(clear crate55)
	(pallet pallet16)
	(surface pallet16)
	(at pallet16 distributor7)
	(clear crate64)
	(pallet pallet17)
	(surface pallet17)
	(at pallet17 distributor8)
	(clear crate43)
	(truck truck0)
	(at truck0 distributor4)
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
	(at hoist8 depot8)
	(available hoist8)
	(hoist hoist9)
	(at hoist9 distributor0)
	(available hoist9)
	(hoist hoist10)
	(at hoist10 distributor1)
	(available hoist10)
	(hoist hoist11)
	(at hoist11 distributor2)
	(available hoist11)
	(hoist hoist12)
	(at hoist12 distributor3)
	(available hoist12)
	(hoist hoist13)
	(at hoist13 distributor4)
	(available hoist13)
	(hoist hoist14)
	(at hoist14 distributor5)
	(available hoist14)
	(hoist hoist15)
	(at hoist15 distributor6)
	(available hoist15)
	(hoist hoist16)
	(at hoist16 distributor7)
	(available hoist16)
	(hoist hoist17)
	(at hoist17 distributor8)
	(available hoist17)
	(crate crate0)
	(surface crate0)
	(at crate0 depot0)
	(on crate0 pallet0)
	(crate crate1)
	(surface crate1)
	(at crate1 depot6)
	(on crate1 pallet6)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor8)
	(on crate2 pallet17)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor8)
	(on crate3 crate2)
	(crate crate4)
	(surface crate4)
	(at crate4 depot1)
	(on crate4 pallet1)
	(crate crate5)
	(surface crate5)
	(at crate5 depot4)
	(on crate5 pallet4)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor4)
	(on crate6 pallet13)
	(crate crate7)
	(surface crate7)
	(at crate7 depot5)
	(on crate7 pallet5)
	(crate crate8)
	(surface crate8)
	(at crate8 distributor3)
	(on crate8 pallet12)
	(crate crate9)
	(surface crate9)
	(at crate9 depot5)
	(on crate9 crate7)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor6)
	(on crate10 pallet15)
	(crate crate11)
	(surface crate11)
	(at crate11 distributor2)
	(on crate11 pallet11)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor5)
	(on crate12 pallet14)
	(crate crate13)
	(surface crate13)
	(at crate13 depot4)
	(on crate13 crate5)
	(crate crate14)
	(surface crate14)
	(at crate14 depot6)
	(on crate14 crate1)
	(crate crate15)
	(surface crate15)
	(at crate15 depot3)
	(on crate15 pallet3)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor6)
	(on crate16 crate10)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor0)
	(on crate17 pallet9)
	(crate crate18)
	(surface crate18)
	(at crate18 depot4)
	(on crate18 crate13)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor8)
	(on crate19 crate3)
	(crate crate20)
	(surface crate20)
	(at crate20 depot2)
	(on crate20 pallet2)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor7)
	(on crate21 pallet16)
	(crate crate22)
	(surface crate22)
	(at crate22 depot3)
	(on crate22 crate15)
	(crate crate23)
	(surface crate23)
	(at crate23 depot0)
	(on crate23 crate0)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor8)
	(on crate24 crate19)
	(crate crate25)
	(surface crate25)
	(at crate25 distributor7)
	(on crate25 crate21)
	(crate crate26)
	(surface crate26)
	(at crate26 depot1)
	(on crate26 crate4)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor2)
	(on crate27 crate11)
	(crate crate28)
	(surface crate28)
	(at crate28 distributor5)
	(on crate28 crate12)
	(crate crate29)
	(surface crate29)
	(at crate29 distributor2)
	(on crate29 crate27)
	(crate crate30)
	(surface crate30)
	(at crate30 depot8)
	(on crate30 pallet8)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor1)
	(on crate31 pallet10)
	(crate crate32)
	(surface crate32)
	(at crate32 depot7)
	(on crate32 pallet7)
	(crate crate33)
	(surface crate33)
	(at crate33 depot3)
	(on crate33 crate22)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor2)
	(on crate34 crate29)
	(crate crate35)
	(surface crate35)
	(at crate35 depot0)
	(on crate35 crate23)
	(crate crate36)
	(surface crate36)
	(at crate36 depot5)
	(on crate36 crate9)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor3)
	(on crate37 crate8)
	(crate crate38)
	(surface crate38)
	(at crate38 depot3)
	(on crate38 crate33)
	(crate crate39)
	(surface crate39)
	(at crate39 depot6)
	(on crate39 crate14)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor8)
	(on crate40 crate24)
	(crate crate41)
	(surface crate41)
	(at crate41 depot0)
	(on crate41 crate35)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor6)
	(on crate42 crate16)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor8)
	(on crate43 crate40)
	(crate crate44)
	(surface crate44)
	(at crate44 distributor0)
	(on crate44 crate17)
	(crate crate45)
	(surface crate45)
	(at crate45 distributor6)
	(on crate45 crate42)
	(crate crate46)
	(surface crate46)
	(at crate46 depot8)
	(on crate46 crate30)
	(crate crate47)
	(surface crate47)
	(at crate47 depot6)
	(on crate47 crate39)
	(crate crate48)
	(surface crate48)
	(at crate48 distributor1)
	(on crate48 crate31)
	(crate crate49)
	(surface crate49)
	(at crate49 distributor1)
	(on crate49 crate48)
	(crate crate50)
	(surface crate50)
	(at crate50 distributor2)
	(on crate50 crate34)
	(crate crate51)
	(surface crate51)
	(at crate51 depot0)
	(on crate51 crate41)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor0)
	(on crate52 crate44)
	(crate crate53)
	(surface crate53)
	(at crate53 depot7)
	(on crate53 crate32)
	(crate crate54)
	(surface crate54)
	(at crate54 depot6)
	(on crate54 crate47)
	(crate crate55)
	(surface crate55)
	(at crate55 distributor6)
	(on crate55 crate45)
	(crate crate56)
	(surface crate56)
	(at crate56 depot0)
	(on crate56 crate51)
	(crate crate57)
	(surface crate57)
	(at crate57 depot7)
	(on crate57 crate53)
	(crate crate58)
	(surface crate58)
	(at crate58 distributor0)
	(on crate58 crate52)
	(crate crate59)
	(surface crate59)
	(at crate59 distributor1)
	(on crate59 crate49)
	(crate crate60)
	(surface crate60)
	(at crate60 depot0)
	(on crate60 crate56)
	(crate crate61)
	(surface crate61)
	(at crate61 depot1)
	(on crate61 crate26)
	(crate crate62)
	(surface crate62)
	(at crate62 distributor7)
	(on crate62 crate25)
	(crate crate63)
	(surface crate63)
	(at crate63 depot5)
	(on crate63 crate36)
	(crate crate64)
	(surface crate64)
	(at crate64 distributor7)
	(on crate64 crate62)
	(crate crate65)
	(surface crate65)
	(at crate65 distributor4)
	(on crate65 crate6)
	(crate crate66)
	(surface crate66)
	(at crate66 depot8)
	(on crate66 crate46)
	(crate crate67)
	(surface crate67)
	(at crate67 depot8)
	(on crate67 crate66)
	(crate crate68)
	(surface crate68)
	(at crate68 depot7)
	(on crate68 crate57)
	(crate crate69)
	(surface crate69)
	(at crate69 distributor4)
	(on crate69 crate65)
	(crate crate70)
	(surface crate70)
	(at crate70 distributor2)
	(on crate70 crate50)
	(crate crate71)
	(surface crate71)
	(at crate71 depot2)
	(on crate71 crate20)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place depot5)
	(place depot6)
	(place depot7)
	(place depot8)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
	(place distributor5)
	(place distributor6)
	(place distributor7)
	(place distributor8)
)

(:goal (and
		(on crate0 crate28)
		(on crate1 crate2)
		(on crate2 crate53)
		(on crate3 crate14)
		(on crate5 crate40)
		(on crate6 pallet7)
		(on crate10 pallet0)
		(on crate11 crate68)
		(on crate12 pallet15)
		(on crate13 crate33)
		(on crate14 crate26)
		(on crate15 crate48)
		(on crate17 pallet5)
		(on crate19 crate62)
		(on crate21 crate51)
		(on crate23 crate67)
		(on crate24 crate41)
		(on crate25 crate66)
		(on crate26 pallet12)
		(on crate28 pallet4)
		(on crate29 crate12)
		(on crate30 pallet16)
		(on crate31 crate13)
		(on crate32 pallet11)
		(on crate33 crate70)
		(on crate34 crate37)
		(on crate35 pallet14)
		(on crate36 pallet13)
		(on crate37 pallet9)
		(on crate38 crate58)
		(on crate39 crate46)
		(on crate40 crate29)
		(on crate41 crate69)
		(on crate42 pallet10)
		(on crate43 crate23)
		(on crate46 crate35)
		(on crate47 pallet8)
		(on crate48 pallet1)
		(on crate49 crate17)
		(on crate50 crate64)
		(on crate51 crate30)
		(on crate52 crate71)
		(on crate53 crate54)
		(on crate54 crate10)
		(on crate55 crate21)
		(on crate56 crate59)
		(on crate57 crate36)
		(on crate58 crate32)
		(on crate59 crate34)
		(on crate60 crate50)
		(on crate61 crate49)
		(on crate62 crate39)
		(on crate63 crate52)
		(on crate64 crate6)
		(on crate65 pallet6)
		(on crate66 crate56)
		(on crate67 crate47)
		(on crate68 crate65)
		(on crate69 pallet17)
		(on crate70 pallet2)
		(on crate71 crate42)
	)
))
