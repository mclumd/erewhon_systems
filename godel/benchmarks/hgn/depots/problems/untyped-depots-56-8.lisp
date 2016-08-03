(define (problem depotprob80) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate53)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate29)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate31)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate48)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear pallet4)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate51)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate34)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor0)
	(clear crate47)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor1)
	(clear crate54)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor2)
	(clear crate25)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor3)
	(clear crate37)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor4)
	(clear crate55)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor5)
	(clear crate50)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor6)
	(clear crate43)
	(truck truck0)
	(at truck0 depot3)
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
	(at crate0 depot5)
	(on crate0 pallet5)
	(crate crate1)
	(surface crate1)
	(at crate1 depot5)
	(on crate1 crate0)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor0)
	(on crate2 pallet7)
	(crate crate3)
	(surface crate3)
	(at crate3 depot6)
	(on crate3 pallet6)
	(crate crate4)
	(surface crate4)
	(at crate4 distributor6)
	(on crate4 pallet13)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor6)
	(on crate5 crate4)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor5)
	(on crate6 pallet12)
	(crate crate7)
	(surface crate7)
	(at crate7 depot0)
	(on crate7 pallet0)
	(crate crate8)
	(surface crate8)
	(at crate8 depot5)
	(on crate8 crate1)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor2)
	(on crate9 pallet9)
	(crate crate10)
	(surface crate10)
	(at crate10 depot0)
	(on crate10 crate7)
	(crate crate11)
	(surface crate11)
	(at crate11 depot6)
	(on crate11 crate3)
	(crate crate12)
	(surface crate12)
	(at crate12 depot0)
	(on crate12 crate10)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor5)
	(on crate13 crate6)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor5)
	(on crate14 crate13)
	(crate crate15)
	(surface crate15)
	(at crate15 depot0)
	(on crate15 crate12)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor2)
	(on crate16 crate9)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor6)
	(on crate17 crate5)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor0)
	(on crate18 crate2)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor1)
	(on crate19 pallet8)
	(crate crate20)
	(surface crate20)
	(at crate20 depot2)
	(on crate20 pallet2)
	(crate crate21)
	(surface crate21)
	(at crate21 depot1)
	(on crate21 pallet1)
	(crate crate22)
	(surface crate22)
	(at crate22 depot1)
	(on crate22 crate21)
	(crate crate23)
	(surface crate23)
	(at crate23 distributor3)
	(on crate23 pallet10)
	(crate crate24)
	(surface crate24)
	(at crate24 depot1)
	(on crate24 crate22)
	(crate crate25)
	(surface crate25)
	(at crate25 distributor2)
	(on crate25 crate16)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor0)
	(on crate26 crate18)
	(crate crate27)
	(surface crate27)
	(at crate27 depot6)
	(on crate27 crate11)
	(crate crate28)
	(surface crate28)
	(at crate28 depot0)
	(on crate28 crate15)
	(crate crate29)
	(surface crate29)
	(at crate29 depot1)
	(on crate29 crate24)
	(crate crate30)
	(surface crate30)
	(at crate30 depot6)
	(on crate30 crate27)
	(crate crate31)
	(surface crate31)
	(at crate31 depot2)
	(on crate31 crate20)
	(crate crate32)
	(surface crate32)
	(at crate32 distributor0)
	(on crate32 crate26)
	(crate crate33)
	(surface crate33)
	(at crate33 depot5)
	(on crate33 crate8)
	(crate crate34)
	(surface crate34)
	(at crate34 depot6)
	(on crate34 crate30)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor0)
	(on crate35 crate32)
	(crate crate36)
	(surface crate36)
	(at crate36 distributor0)
	(on crate36 crate35)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor3)
	(on crate37 crate23)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor4)
	(on crate38 pallet11)
	(crate crate39)
	(surface crate39)
	(at crate39 depot3)
	(on crate39 pallet3)
	(crate crate40)
	(surface crate40)
	(at crate40 distributor5)
	(on crate40 crate14)
	(crate crate41)
	(surface crate41)
	(at crate41 depot0)
	(on crate41 crate28)
	(crate crate42)
	(surface crate42)
	(at crate42 depot0)
	(on crate42 crate41)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor6)
	(on crate43 crate17)
	(crate crate44)
	(surface crate44)
	(at crate44 distributor5)
	(on crate44 crate40)
	(crate crate45)
	(surface crate45)
	(at crate45 depot0)
	(on crate45 crate42)
	(crate crate46)
	(surface crate46)
	(at crate46 depot3)
	(on crate46 crate39)
	(crate crate47)
	(surface crate47)
	(at crate47 distributor0)
	(on crate47 crate36)
	(crate crate48)
	(surface crate48)
	(at crate48 depot3)
	(on crate48 crate46)
	(crate crate49)
	(surface crate49)
	(at crate49 distributor5)
	(on crate49 crate44)
	(crate crate50)
	(surface crate50)
	(at crate50 distributor5)
	(on crate50 crate49)
	(crate crate51)
	(surface crate51)
	(at crate51 depot5)
	(on crate51 crate33)
	(crate crate52)
	(surface crate52)
	(at crate52 depot0)
	(on crate52 crate45)
	(crate crate53)
	(surface crate53)
	(at crate53 depot0)
	(on crate53 crate52)
	(crate crate54)
	(surface crate54)
	(at crate54 distributor1)
	(on crate54 crate19)
	(crate crate55)
	(surface crate55)
	(at crate55 distributor4)
	(on crate55 crate38)
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
		(on crate0 crate36)
		(on crate1 crate17)
		(on crate2 pallet6)
		(on crate4 crate52)
		(on crate5 pallet11)
		(on crate6 crate51)
		(on crate7 crate18)
		(on crate8 crate4)
		(on crate9 crate48)
		(on crate10 crate35)
		(on crate11 crate42)
		(on crate12 crate9)
		(on crate13 crate12)
		(on crate14 pallet5)
		(on crate16 pallet0)
		(on crate17 crate30)
		(on crate18 crate55)
		(on crate19 pallet12)
		(on crate20 crate6)
		(on crate21 pallet9)
		(on crate22 crate32)
		(on crate24 crate54)
		(on crate25 crate39)
		(on crate26 crate25)
		(on crate29 crate16)
		(on crate30 pallet2)
		(on crate31 pallet3)
		(on crate32 crate2)
		(on crate33 pallet8)
		(on crate34 crate20)
		(on crate35 pallet4)
		(on crate36 crate5)
		(on crate37 pallet10)
		(on crate38 crate45)
		(on crate39 crate33)
		(on crate40 crate24)
		(on crate42 crate10)
		(on crate43 crate19)
		(on crate44 crate13)
		(on crate45 pallet7)
		(on crate46 crate21)
		(on crate47 crate22)
		(on crate48 pallet13)
		(on crate49 crate37)
		(on crate50 crate26)
		(on crate51 crate31)
		(on crate52 crate49)
		(on crate53 crate40)
		(on crate54 crate14)
		(on crate55 crate43)
	)
))