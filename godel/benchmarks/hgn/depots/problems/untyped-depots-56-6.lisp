(define (problem depotprob60) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear pallet0)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate54)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate44)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate55)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate4)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate36)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 depot6)
	(clear crate29)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor0)
	(clear crate51)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor1)
	(clear crate27)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor2)
	(clear crate48)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor3)
	(clear crate42)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor4)
	(clear crate52)
	(pallet pallet12)
	(surface pallet12)
	(at pallet12 distributor5)
	(clear crate53)
	(pallet pallet13)
	(surface pallet13)
	(at pallet13 distributor6)
	(clear crate24)
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
	(at crate1 distributor0)
	(on crate1 pallet7)
	(crate crate2)
	(surface crate2)
	(at crate2 distributor0)
	(on crate2 crate1)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor3)
	(on crate3 pallet10)
	(crate crate4)
	(surface crate4)
	(at crate4 depot4)
	(on crate4 pallet4)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor3)
	(on crate5 crate3)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor5)
	(on crate6 pallet12)
	(crate crate7)
	(surface crate7)
	(at crate7 depot5)
	(on crate7 pallet5)
	(crate crate8)
	(surface crate8)
	(at crate8 distributor3)
	(on crate8 crate5)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor2)
	(on crate9 pallet9)
	(crate crate10)
	(surface crate10)
	(at crate10 depot1)
	(on crate10 crate0)
	(crate crate11)
	(surface crate11)
	(at crate11 depot2)
	(on crate11 pallet2)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor4)
	(on crate12 pallet11)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor4)
	(on crate13 crate12)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor1)
	(on crate14 pallet8)
	(crate crate15)
	(surface crate15)
	(at crate15 depot2)
	(on crate15 crate11)
	(crate crate16)
	(surface crate16)
	(at crate16 depot2)
	(on crate16 crate15)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor5)
	(on crate17 crate6)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor1)
	(on crate18 crate14)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor0)
	(on crate19 crate2)
	(crate crate20)
	(surface crate20)
	(at crate20 depot5)
	(on crate20 crate7)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor6)
	(on crate21 pallet13)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor3)
	(on crate22 crate8)
	(crate crate23)
	(surface crate23)
	(at crate23 distributor3)
	(on crate23 crate22)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor6)
	(on crate24 crate21)
	(crate crate25)
	(surface crate25)
	(at crate25 depot6)
	(on crate25 pallet6)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor4)
	(on crate26 crate13)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor1)
	(on crate27 crate18)
	(crate crate28)
	(surface crate28)
	(at crate28 depot6)
	(on crate28 crate25)
	(crate crate29)
	(surface crate29)
	(at crate29 depot6)
	(on crate29 crate28)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor2)
	(on crate30 crate9)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor3)
	(on crate31 crate23)
	(crate crate32)
	(surface crate32)
	(at crate32 depot5)
	(on crate32 crate20)
	(crate crate33)
	(surface crate33)
	(at crate33 distributor0)
	(on crate33 crate19)
	(crate crate34)
	(surface crate34)
	(at crate34 depot3)
	(on crate34 pallet3)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor5)
	(on crate35 crate17)
	(crate crate36)
	(surface crate36)
	(at crate36 depot5)
	(on crate36 crate32)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor5)
	(on crate37 crate35)
	(crate crate38)
	(surface crate38)
	(at crate38 depot3)
	(on crate38 crate34)
	(crate crate39)
	(surface crate39)
	(at crate39 distributor2)
	(on crate39 crate30)
	(crate crate40)
	(surface crate40)
	(at crate40 depot1)
	(on crate40 crate10)
	(crate crate41)
	(surface crate41)
	(at crate41 depot2)
	(on crate41 crate16)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor3)
	(on crate42 crate31)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor0)
	(on crate43 crate33)
	(crate crate44)
	(surface crate44)
	(at crate44 depot2)
	(on crate44 crate41)
	(crate crate45)
	(surface crate45)
	(at crate45 depot3)
	(on crate45 crate38)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor2)
	(on crate46 crate39)
	(crate crate47)
	(surface crate47)
	(at crate47 distributor2)
	(on crate47 crate46)
	(crate crate48)
	(surface crate48)
	(at crate48 distributor2)
	(on crate48 crate47)
	(crate crate49)
	(surface crate49)
	(at crate49 depot1)
	(on crate49 crate40)
	(crate crate50)
	(surface crate50)
	(at crate50 depot3)
	(on crate50 crate45)
	(crate crate51)
	(surface crate51)
	(at crate51 distributor0)
	(on crate51 crate43)
	(crate crate52)
	(surface crate52)
	(at crate52 distributor4)
	(on crate52 crate26)
	(crate crate53)
	(surface crate53)
	(at crate53 distributor5)
	(on crate53 crate37)
	(crate crate54)
	(surface crate54)
	(at crate54 depot1)
	(on crate54 crate49)
	(crate crate55)
	(surface crate55)
	(at crate55 depot3)
	(on crate55 crate50)
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
		(on crate0 pallet6)
		(on crate1 crate20)
		(on crate3 pallet5)
		(on crate4 pallet12)
		(on crate6 crate14)
		(on crate7 crate35)
		(on crate8 crate27)
		(on crate9 pallet9)
		(on crate10 crate43)
		(on crate11 crate53)
		(on crate12 pallet11)
		(on crate13 crate49)
		(on crate14 crate24)
		(on crate15 crate17)
		(on crate17 crate45)
		(on crate18 pallet8)
		(on crate19 crate42)
		(on crate20 crate26)
		(on crate21 pallet13)
		(on crate23 pallet3)
		(on crate24 pallet1)
		(on crate25 crate36)
		(on crate26 crate6)
		(on crate27 crate30)
		(on crate28 crate33)
		(on crate29 crate13)
		(on crate30 pallet7)
		(on crate31 crate38)
		(on crate32 crate3)
		(on crate33 crate18)
		(on crate34 crate7)
		(on crate35 pallet2)
		(on crate36 crate9)
		(on crate37 crate0)
		(on crate38 crate51)
		(on crate40 crate41)
		(on crate41 crate28)
		(on crate42 crate4)
		(on crate43 crate46)
		(on crate45 crate34)
		(on crate46 crate23)
		(on crate47 crate31)
		(on crate48 pallet10)
		(on crate49 pallet0)
		(on crate51 pallet4)
		(on crate52 crate40)
		(on crate53 crate25)
	)
))
