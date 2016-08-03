(define (problem depotprob210) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate33)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate53)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate51)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate50)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate54)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate42)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate41)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor0)
	(clear crate44)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor1)
	(clear crate37)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor2)
	(clear crate49)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor3)
	(clear pallet10)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor4)
	(clear crate55)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor5)
	(clear crate30)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor6)
	(clear crate46)
	(truck truck0)
	(at truck0 distributor0)
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
	(at hoist7 distributor0)
	(available hoist7)
	(hoist hoist8)
	(at hoist8 distributor1)
	(available hoist8)
	(hoist hoist9)
	(at hoist9 distributor2)
	(available hoist9)
	(hoist hoist10)
	(at hoist10 distributor3)
	(available hoist10)
	(hoist hoist11)
	(at hoist11 distributor4)
	(available hoist11)
	(hoist hoist12)
	(at hoist12 distributor5)
	(available hoist12)
	(hoist hoist13)
	(at hoist13 distributor6)
	(available hoist13)
	(crate crate0)
	(surface crate0)
	(at crate0 depot1)
	(on crate0 pallet1)
	(crate crate1)
	(surface crate1)
	(at crate1 depot3)
	(on crate1 pallet3)
	(crate crate2)
	(surface crate2)
	(at crate2 depot1)
	(on crate2 crate0)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor1)
	(on crate3 pallet8)
	(crate crate4)
	(surface crate4)
	(at crate4 distributor2)
	(on crate4 pallet9)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor4)
	(on crate5 pallet11)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor6)
	(on crate6 pallet13)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor6)
	(on crate7 crate6)
	(crate crate8)
	(surface crate8)
	(at crate8 depot6)
	(on crate8 pallet6)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor6)
	(on crate9 crate7)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor5)
	(on crate10 pallet12)
	(crate crate11)
	(surface crate11)
	(at crate11 depot5)
	(on crate11 pallet5)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor1)
	(on crate12 crate3)
	(crate crate13)
	(surface crate13)
	(at crate13 depot6)
	(on crate13 crate8)
	(crate crate14)
	(surface crate14)
	(at crate14 depot0)
	(on crate14 pallet0)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor0)
	(on crate15 pallet7)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor0)
	(on crate16 crate15)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor4)
	(on crate17 crate5)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor0)
	(on crate18 crate16)
	(crate crate19)
	(surface crate19)
	(at crate19 depot4)
	(on crate19 pallet4)
	(crate crate20)
	(surface crate20)
	(at crate20 depot1)
	(on crate20 crate2)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor0)
	(on crate21 crate18)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor6)
	(on crate22 crate9)
	(crate crate23)
	(surface crate23)
	(at crate23 depot0)
	(on crate23 crate14)
	(crate crate24)
	(surface crate24)
	(at crate24 depot4)
	(on crate24 crate19)
	(crate crate25)
	(surface crate25)
	(at crate25 depot1)
	(on crate25 crate20)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor4)
	(on crate26 crate17)
	(crate crate27)
	(surface crate27)
	(at crate27 depot4)
	(on crate27 crate24)
	(crate crate28)
	(surface crate28)
	(at crate28 depot1)
	(on crate28 crate25)
	(crate crate29)
	(surface crate29)
	(at crate29 distributor4)
	(on crate29 crate26)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor5)
	(on crate30 crate10)
	(crate crate31)
	(surface crate31)
	(at crate31 depot4)
	(on crate31 crate27)
	(crate crate32)
	(surface crate32)
	(at crate32 depot0)
	(on crate32 crate23)
	(crate crate33)
	(surface crate33)
	(at crate33 depot0)
	(on crate33 crate32)
	(crate crate34)
	(surface crate34)
	(at crate34 depot6)
	(on crate34 crate13)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor4)
	(on crate35 crate29)
	(crate crate36)
	(surface crate36)
	(at crate36 depot6)
	(on crate36 crate34)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor1)
	(on crate37 crate12)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor4)
	(on crate38 crate35)
	(crate crate39)
	(surface crate39)
	(at crate39 distributor4)
	(on crate39 crate38)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor0)
	(on crate40 crate21)
	(crate crate41)
	(surface crate41)
	(at crate41 depot6)
	(on crate41 crate36)
	(crate crate42)
	(surface crate42)
	(at crate42 depot5)
	(on crate42 crate11)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor4)
	(on crate43 crate39)
	(crate crate44)
	(surface crate44)
	(at crate44 distributor0)
	(on crate44 crate40)
	(crate crate45)
	(surface crate45)
	(at crate45 distributor2)
	(on crate45 crate4)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor6)
	(on crate46 crate22)
	(crate crate47)
	(surface crate47)
	(at crate47 distributor4)
	(on crate47 crate43)
	(crate crate48)
	(surface crate48)
	(at crate48 depot1)
	(on crate48 crate28)
	(crate crate49)
	(surface crate49)
	(at crate49 distributor2)
	(on crate49 crate45)
	(crate crate50)
	(surface crate50)
	(at crate50 depot3)
	(on crate50 crate1)
	(crate crate51)
	(surface crate51)
	(at crate51 depot2)
	(on crate51 pallet2)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor4)
	(on crate52 crate47)
	(crate crate53)
	(surface crate53)
	(at crate53 depot1)
	(on crate53 crate48)
	(crate crate54)
	(surface crate54)
	(at crate54 depot4)
	(on crate54 crate31)
	(crate crate55)
	(surface crate55)
	(at crate55 distributor4)
	(on crate55 crate52)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place depot5)
	(place depot6)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
	(place distributor5)
	(place distributor6)
)

(:goal (and
		(on crate0 pallet5)
		(on crate1 crate11)
		(on crate2 crate31)
		(on crate3 crate26)
		(on crate4 pallet11)
		(on crate5 crate0)
		(on crate6 crate9)
		(on crate7 crate16)
		(on crate8 crate38)
		(on crate9 pallet4)
		(on crate10 crate5)
		(on crate11 crate17)
		(on crate12 crate54)
		(on crate13 crate29)
		(on crate15 crate24)
		(on crate16 pallet1)
		(on crate17 pallet3)
		(on crate19 pallet2)
		(on crate20 pallet8)
		(on crate21 crate39)
		(on crate22 crate10)
		(on crate23 crate8)
		(on crate24 crate27)
		(on crate25 crate47)
		(on crate26 crate30)
		(on crate27 pallet7)
		(on crate28 pallet13)
		(on crate29 pallet10)
		(on crate30 crate49)
		(on crate31 crate33)
		(on crate32 pallet9)
		(on crate33 crate44)
		(on crate34 crate20)
		(on crate35 crate40)
		(on crate37 pallet6)
		(on crate38 crate46)
		(on crate39 pallet0)
		(on crate40 crate48)
		(on crate43 crate7)
		(on crate44 crate32)
		(on crate46 crate28)
		(on crate47 crate6)
		(on crate48 crate15)
		(on crate49 crate4)
		(on crate50 pallet12)
		(on crate51 crate12)
		(on crate52 crate2)
		(on crate53 crate51)
		(on crate54 crate34)
	)
))
