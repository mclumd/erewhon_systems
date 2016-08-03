(define (problem depotprob20) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate69)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate62)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate67)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate78)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate72)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate79)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate60)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 depot7)
	(clear crate71)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 depot8)
	(clear crate66)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 depot9)
	(clear crate51)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor0)
	(clear crate12)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor1)
	(clear crate48)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor2)
	(clear crate76)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor3)
	(clear crate41)
	(pallet pallet14)
	(surface pallet14)
	(at pallet14 distributor4)
	(clear crate55)
	(pallet pallet15)
	(surface pallet15)
	(at pallet15 distributor5)
	(clear crate77)
	(pallet pallet16)
	(surface pallet16)
	(at pallet16 distributor6)
	(clear crate45)
	(pallet pallet17)
	(surface pallet17)
	(at pallet17 distributor7)
	(clear crate73)
	(pallet pallet18)
	(surface pallet18)
	(at pallet18 distributor8)
	(clear crate75)
	(pallet pallet19)
	(surface pallet19)
	(at pallet19 distributor9)
	(clear crate68)
	(truck truck0)
	(at truck0 depot6)
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
	(at crate0 distributor7)
	(on crate0 pallet17)
	(crate crate1)
	(surface crate1)
	(at crate1 depot8)
	(on crate1 pallet8)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor8)
	(on crate2 pallet18)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor3)
	(on crate3 pallet13)
	(crate crate4)
	(surface crate4)
	(at crate4 depot0)
	(on crate4 pallet0)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor8)
	(on crate5 crate2)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor2)
	(on crate6 pallet12)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor8)
	(on crate7 crate5)
	(crate crate8)
	(surface crate8)
	(at crate8 depot6)
	(on crate8 pallet6)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor2)
	(on crate9 crate6)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor9)
	(on crate10 pallet19)
	(crate crate11)
	(surface crate11)
	(at crate11 depot7)
	(on crate11 pallet7)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor0)
	(on crate12 pallet10)
	(crate crate13)
	(surface crate13)
	(at crate13 depot5)
	(on crate13 pallet5)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor5)
	(on crate14 pallet15)
	(crate crate15)
	(surface crate15)
	(at crate15 depot8)
	(on crate15 crate1)
	(crate crate16)
	(surface crate16)
	(at crate16 depot2)
	(on crate16 pallet2)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor6)
	(on crate17 pallet16)
	(crate crate18)
	(surface crate18)
	(at crate18 depot2)
	(on crate18 crate16)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor5)
	(on crate19 crate14)
	(crate crate20)
	(surface crate20)
	(at crate20 depot6)
	(on crate20 crate8)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor2)
	(on crate21 crate9)
	(crate crate22)
	(surface crate22)
	(at crate22 depot4)
	(on crate22 pallet4)
	(crate crate23)
	(surface crate23)
	(at crate23 depot1)
	(on crate23 pallet1)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor6)
	(on crate24 crate17)
	(crate crate25)
	(surface crate25)
	(at crate25 distributor7)
	(on crate25 crate0)
	(crate crate26)
	(surface crate26)
	(at crate26 depot2)
	(on crate26 crate18)
	(crate crate27)
	(surface crate27)
	(at crate27 depot2)
	(on crate27 crate26)
	(crate crate28)
	(surface crate28)
	(at crate28 depot0)
	(on crate28 crate4)
	(crate crate29)
	(surface crate29)
	(at crate29 depot8)
	(on crate29 crate15)
	(crate crate30)
	(surface crate30)
	(at crate30 depot7)
	(on crate30 crate11)
	(crate crate31)
	(surface crate31)
	(at crate31 depot9)
	(on crate31 pallet9)
	(crate crate32)
	(surface crate32)
	(at crate32 distributor3)
	(on crate32 crate3)
	(crate crate33)
	(surface crate33)
	(at crate33 distributor1)
	(on crate33 pallet11)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor5)
	(on crate34 crate19)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor7)
	(on crate35 crate25)
	(crate crate36)
	(surface crate36)
	(at crate36 depot1)
	(on crate36 crate23)
	(crate crate37)
	(surface crate37)
	(at crate37 depot2)
	(on crate37 crate27)
	(crate crate38)
	(surface crate38)
	(at crate38 depot1)
	(on crate38 crate36)
	(crate crate39)
	(surface crate39)
	(at crate39 distributor7)
	(on crate39 crate35)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor7)
	(on crate40 crate39)
	(crate crate41)
	(surface crate41)
	(at crate41 distributor3)
	(on crate41 crate32)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor9)
	(on crate42 crate10)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor2)
	(on crate43 crate21)
	(crate crate44)
	(surface crate44)
	(at crate44 depot4)
	(on crate44 crate22)
	(crate crate45)
	(surface crate45)
	(at crate45 distributor6)
	(on crate45 crate24)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor7)
	(on crate46 crate40)
	(crate crate47)
	(surface crate47)
	(at crate47 depot2)
	(on crate47 crate37)
	(crate crate48)
	(surface crate48)
	(at crate48 distributor1)
	(on crate48 crate33)
	(crate crate49)
	(surface crate49)
	(at crate49 depot7)
	(on crate49 crate30)
	(crate crate50)
	(surface crate50)
	(at crate50 depot1)
	(on crate50 crate38)
	(crate crate51)
	(surface crate51)
	(at crate51 depot9)
	(on crate51 crate31)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor5)
	(on crate52 crate34)
	(crate crate53)
	(surface crate53)
	(at crate53 depot8)
	(on crate53 crate29)
	(crate crate54)
	(surface crate54)
	(at crate54 distributor4)
	(on crate54 pallet14)
	(crate crate55)
	(surface crate55)
	(at crate55 distributor4)
	(on crate55 crate54)
	(crate crate56)
	(surface crate56)
	(at crate56 depot0)
	(on crate56 crate28)
	(crate crate57)
	(surface crate57)
	(at crate57 distributor2)
	(on crate57 crate43)
	(crate crate58)
	(surface crate58)
	(at crate58 depot5)
	(on crate58 crate13)
	(crate crate59)
	(surface crate59)
	(at crate59 distributor9)
	(on crate59 crate42)
	(crate crate60)
	(surface crate60)
	(at crate60 depot6)
	(on crate60 crate20)
	(crate crate61)
	(surface crate61)
	(at crate61 depot1)
	(on crate61 crate50)
	(crate crate62)
	(surface crate62)
	(at crate62 depot1)
	(on crate62 crate61)
	(crate crate63)
	(surface crate63)
	(at crate63 distributor5)
	(on crate63 crate52)
	(crate crate64)
	(surface crate64)
	(at crate64 distributor8)
	(on crate64 crate7)
	(crate crate65)
	(surface crate65)
	(at crate65 distributor9)
	(on crate65 crate59)
	(crate crate66)
	(surface crate66)
	(at crate66 depot8)
	(on crate66 crate53)
	(crate crate67)
	(surface crate67)
	(at crate67 depot2)
	(on crate67 crate47)
	(crate crate68)
	(surface crate68)
	(at crate68 distributor9)
	(on crate68 crate65)
	(crate crate69)
	(surface crate69)
	(at crate69 depot0)
	(on crate69 crate56)
	(crate crate70)
	(surface crate70)
	(at crate70 distributor7)
	(on crate70 crate46)
	(crate crate71)
	(surface crate71)
	(at crate71 depot7)
	(on crate71 crate49)
	(crate crate72)
	(surface crate72)
	(at crate72 depot4)
	(on crate72 crate44)
	(crate crate73)
	(surface crate73)
	(at crate73 distributor7)
	(on crate73 crate70)
	(crate crate74)
	(surface crate74)
	(at crate74 depot5)
	(on crate74 crate58)
	(crate crate75)
	(surface crate75)
	(at crate75 distributor8)
	(on crate75 crate64)
	(crate crate76)
	(surface crate76)
	(at crate76 distributor2)
	(on crate76 crate57)
	(crate crate77)
	(surface crate77)
	(at crate77 distributor5)
	(on crate77 crate63)
	(crate crate78)
	(surface crate78)
	(at crate78 depot3)
	(on crate78 pallet3)
	(crate crate79)
	(surface crate79)
	(at crate79 depot5)
	(on crate79 crate74)
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
