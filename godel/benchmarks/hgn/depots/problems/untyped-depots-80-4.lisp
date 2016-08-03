(define (problem depotprob40) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate64)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate21)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate75)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate79)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate62)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate46)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate36)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 depot7)
	(clear crate55)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 depot8)
	(clear crate77)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 depot9)
	(clear crate47)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor0)
	(clear crate58)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor1)
	(clear crate74)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor2)
	(clear crate68)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor3)
	(clear crate51)
	(pallet pallet14)
	(surface pallet14)
	(at pallet14 distributor4)
	(clear crate78)
	(pallet pallet15)
	(surface pallet15)
	(at pallet15 distributor5)
	(clear crate71)
	(pallet pallet16)
	(surface pallet16)
	(at pallet16 distributor6)
	(clear crate70)
	(pallet pallet17)
	(surface pallet17)
	(at pallet17 distributor7)
	(clear crate76)
	(pallet pallet18)
	(surface pallet18)
	(at pallet18 distributor8)
	(clear crate53)
	(pallet pallet19)
	(surface pallet19)
	(at pallet19 distributor9)
	(clear crate27)
	(truck truck0)
	(at truck0 distributor3)
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
	(at hoist9 depot9)
	(available hoist9)
	(hoist hoist10)
	(at hoist10 distributor0)
	(available hoist10)
	(hoist hoist11)
	(at hoist11 distributor1)
	(available hoist11)
	(hoist hoist12)
	(at hoist12 distributor2)
	(available hoist12)
	(hoist hoist13)
	(at hoist13 distributor3)
	(available hoist13)
	(hoist hoist14)
	(at hoist14 distributor4)
	(available hoist14)
	(hoist hoist15)
	(at hoist15 distributor5)
	(available hoist15)
	(hoist hoist16)
	(at hoist16 distributor6)
	(available hoist16)
	(hoist hoist17)
	(at hoist17 distributor7)
	(available hoist17)
	(hoist hoist18)
	(at hoist18 distributor8)
	(available hoist18)
	(hoist hoist19)
	(at hoist19 distributor9)
	(available hoist19)
	(crate crate0)
	(surface crate0)
	(at crate0 depot6)
	(on crate0 pallet6)
	(crate crate1)
	(surface crate1)
	(at crate1 depot1)
	(on crate1 pallet1)
	(crate crate2)
	(surface crate2)
	(at crate2 depot0)
	(on crate2 pallet0)
	(crate crate3)
	(surface crate3)
	(at crate3 depot8)
	(on crate3 pallet8)
	(crate crate4)
	(surface crate4)
	(at crate4 depot7)
	(on crate4 pallet7)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor2)
	(on crate5 pallet12)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor8)
	(on crate6 pallet18)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor8)
	(on crate7 crate6)
	(crate crate8)
	(surface crate8)
	(at crate8 distributor6)
	(on crate8 pallet16)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor0)
	(on crate9 pallet10)
	(crate crate10)
	(surface crate10)
	(at crate10 depot5)
	(on crate10 pallet5)
	(crate crate11)
	(surface crate11)
	(at crate11 depot4)
	(on crate11 pallet4)
	(crate crate12)
	(surface crate12)
	(at crate12 depot8)
	(on crate12 crate3)
	(crate crate13)
	(surface crate13)
	(at crate13 depot6)
	(on crate13 crate0)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor7)
	(on crate14 pallet17)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor4)
	(on crate15 pallet14)
	(crate crate16)
	(surface crate16)
	(at crate16 depot1)
	(on crate16 crate1)
	(crate crate17)
	(surface crate17)
	(at crate17 depot7)
	(on crate17 crate4)
	(crate crate18)
	(surface crate18)
	(at crate18 depot2)
	(on crate18 pallet2)
	(crate crate19)
	(surface crate19)
	(at crate19 depot2)
	(on crate19 crate18)
	(crate crate20)
	(surface crate20)
	(at crate20 distributor2)
	(on crate20 crate5)
	(crate crate21)
	(surface crate21)
	(at crate21 depot1)
	(on crate21 crate16)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor2)
	(on crate22 crate20)
	(crate crate23)
	(surface crate23)
	(at crate23 distributor2)
	(on crate23 crate22)
	(crate crate24)
	(surface crate24)
	(at crate24 depot0)
	(on crate24 crate2)
	(crate crate25)
	(surface crate25)
	(at crate25 depot7)
	(on crate25 crate17)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor6)
	(on crate26 crate8)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor9)
	(on crate27 pallet19)
	(crate crate28)
	(surface crate28)
	(at crate28 depot5)
	(on crate28 crate10)
	(crate crate29)
	(surface crate29)
	(at crate29 depot0)
	(on crate29 crate24)
	(crate crate30)
	(surface crate30)
	(at crate30 depot5)
	(on crate30 crate28)
	(crate crate31)
	(surface crate31)
	(at crate31 depot6)
	(on crate31 crate13)
	(crate crate32)
	(surface crate32)
	(at crate32 depot9)
	(on crate32 pallet9)
	(crate crate33)
	(surface crate33)
	(at crate33 depot9)
	(on crate33 crate32)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor1)
	(on crate34 pallet11)
	(crate crate35)
	(surface crate35)
	(at crate35 depot3)
	(on crate35 pallet3)
	(crate crate36)
	(surface crate36)
	(at crate36 depot6)
	(on crate36 crate31)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor5)
	(on crate37 pallet15)
	(crate crate38)
	(surface crate38)
	(at crate38 depot4)
	(on crate38 crate11)
	(crate crate39)
	(surface crate39)
	(at crate39 depot8)
	(on crate39 crate12)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor0)
	(on crate40 crate9)
	(crate crate41)
	(surface crate41)
	(at crate41 distributor2)
	(on crate41 crate23)
	(crate crate42)
	(surface crate42)
	(at crate42 depot8)
	(on crate42 crate39)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor0)
	(on crate43 crate40)
	(crate crate44)
	(surface crate44)
	(at crate44 distributor7)
	(on crate44 crate14)
	(crate crate45)
	(surface crate45)
	(at crate45 distributor6)
	(on crate45 crate26)
	(crate crate46)
	(surface crate46)
	(at crate46 depot5)
	(on crate46 crate30)
	(crate crate47)
	(surface crate47)
	(at crate47 depot9)
	(on crate47 crate33)
	(crate crate48)
	(surface crate48)
	(at crate48 distributor7)
	(on crate48 crate44)
	(crate crate49)
	(surface crate49)
	(at crate49 depot8)
	(on crate49 crate42)
	(crate crate50)
	(surface crate50)
	(at crate50 distributor1)
	(on crate50 crate34)
	(crate crate51)
	(surface crate51)
	(at crate51 distributor3)
	(on crate51 pallet13)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor6)
	(on crate52 crate45)
	(crate crate53)
	(surface crate53)
	(at crate53 distributor8)
	(on crate53 crate7)
	(crate crate54)
	(surface crate54)
	(at crate54 distributor6)
	(on crate54 crate52)
	(crate crate55)
	(surface crate55)
	(at crate55 depot7)
	(on crate55 crate25)
	(crate crate56)
	(surface crate56)
	(at crate56 depot3)
	(on crate56 crate35)
	(crate crate57)
	(surface crate57)
	(at crate57 distributor2)
	(on crate57 crate41)
	(crate crate58)
	(surface crate58)
	(at crate58 distributor0)
	(on crate58 crate43)
	(crate crate59)
	(surface crate59)
	(at crate59 depot4)
	(on crate59 crate38)
	(crate crate60)
	(surface crate60)
	(at crate60 distributor5)
	(on crate60 crate37)
	(crate crate61)
	(surface crate61)
	(at crate61 distributor1)
	(on crate61 crate50)
	(crate crate62)
	(surface crate62)
	(at crate62 depot4)
	(on crate62 crate59)
	(crate crate63)
	(surface crate63)
	(at crate63 distributor6)
	(on crate63 crate54)
	(crate crate64)
	(surface crate64)
	(at crate64 depot0)
	(on crate64 crate29)
	(crate crate65)
	(surface crate65)
	(at crate65 distributor1)
	(on crate65 crate61)
	(crate crate66)
	(surface crate66)
	(at crate66 distributor7)
	(on crate66 crate48)
	(crate crate67)
	(surface crate67)
	(at crate67 distributor1)
	(on crate67 crate65)
	(crate crate68)
	(surface crate68)
	(at crate68 distributor2)
	(on crate68 crate57)
	(crate crate69)
	(surface crate69)
	(at crate69 distributor5)
	(on crate69 crate60)
	(crate crate70)
	(surface crate70)
	(at crate70 distributor6)
	(on crate70 crate63)
	(crate crate71)
	(surface crate71)
	(at crate71 distributor5)
	(on crate71 crate69)
	(crate crate72)
	(surface crate72)
	(at crate72 depot2)
	(on crate72 crate19)
	(crate crate73)
	(surface crate73)
	(at crate73 distributor1)
	(on crate73 crate67)
	(crate crate74)
	(surface crate74)
	(at crate74 distributor1)
	(on crate74 crate73)
	(crate crate75)
	(surface crate75)
	(at crate75 depot2)
	(on crate75 crate72)
	(crate crate76)
	(surface crate76)
	(at crate76 distributor7)
	(on crate76 crate66)
	(crate crate77)
	(surface crate77)
	(at crate77 depot8)
	(on crate77 crate49)
	(crate crate78)
	(surface crate78)
	(at crate78 distributor4)
	(on crate78 crate15)
	(crate crate79)
	(surface crate79)
	(at crate79 depot3)
	(on crate79 crate56)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place depot5)
	(place depot6)
	(place depot7)
	(place depot8)
	(place depot9)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
	(place distributor5)
	(place distributor6)
	(place distributor7)
	(place distributor8)
	(place distributor9)
)

(:goal (and
		(on crate0 pallet2)
		(on crate1 crate15)
		(on crate2 crate66)
		(on crate3 crate51)
		(on crate4 crate49)
		(on crate5 pallet14)
		(on crate6 crate5)
		(on crate7 crate21)
		(on crate8 crate53)
		(on crate9 crate65)
		(on crate10 crate22)
		(on crate11 pallet18)
		(on crate13 crate38)
		(on crate14 crate63)
		(on crate15 crate70)
		(on crate16 pallet3)
		(on crate17 pallet4)
		(on crate18 crate39)
		(on crate21 crate48)
		(on crate22 crate9)
		(on crate23 crate1)
		(on crate24 crate64)
		(on crate25 crate30)
		(on crate26 pallet1)
		(on crate27 crate0)
		(on crate28 pallet5)
		(on crate29 crate57)
		(on crate30 crate18)
		(on crate31 crate75)
		(on crate32 crate14)
		(on crate33 crate11)
		(on crate34 pallet19)
		(on crate37 crate44)
		(on crate38 crate34)
		(on crate39 pallet12)
		(on crate41 crate59)
		(on crate43 crate33)
		(on crate44 pallet7)
		(on crate45 crate10)
		(on crate46 crate7)
		(on crate48 pallet9)
		(on crate49 crate61)
		(on crate50 crate17)
		(on crate51 pallet16)
		(on crate52 crate76)
		(on crate53 crate74)
		(on crate54 crate56)
		(on crate55 pallet11)
		(on crate56 crate3)
		(on crate57 crate72)
		(on crate59 pallet8)
		(on crate60 crate32)
		(on crate61 crate27)
		(on crate63 pallet10)
		(on crate64 crate77)
		(on crate65 pallet6)
		(on crate66 crate79)
		(on crate67 crate41)
		(on crate68 pallet15)
		(on crate70 pallet17)
		(on crate71 crate24)
		(on crate72 crate78)
		(on crate73 crate8)
		(on crate74 pallet0)
		(on crate75 crate60)
		(on crate76 crate31)
		(on crate77 crate68)
		(on crate78 crate26)
		(on crate79 pallet13)
	)
))
