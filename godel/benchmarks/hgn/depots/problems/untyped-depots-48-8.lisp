(define (problem depotprob80) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate44)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear pallet1)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate28)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate25)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate37)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate40)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 distributor0)
	(clear crate47)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor1)
	(clear crate20)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor2)
	(clear crate45)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor3)
	(clear crate17)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor4)
	(clear crate43)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor5)
	(clear crate46)
	(truck truck0)
	(at truck0 depot1)
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
	(at hoist6 distributor0)
	(available hoist6)
	(hoist hoist7)
	(at hoist7 distributor1)
	(available hoist7)
	(hoist hoist8)
	(at hoist8 distributor2)
	(available hoist8)
	(hoist hoist9)
	(at hoist9 distributor3)
	(available hoist9)
	(hoist hoist10)
	(at hoist10 distributor4)
	(available hoist10)
	(hoist hoist11)
	(at hoist11 distributor5)
	(available hoist11)
	(crate crate0)
	(surface crate0)
	(at crate0 distributor1)
	(on crate0 pallet7)
	(crate crate1)
	(surface crate1)
	(at crate1 depot4)
	(on crate1 pallet4)
	(crate crate2)
	(surface crate2)
	(at crate2 depot2)
	(on crate2 pallet2)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor3)
	(on crate3 pallet9)
	(crate crate4)
	(surface crate4)
	(at crate4 distributor2)
	(on crate4 pallet8)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor1)
	(on crate5 crate0)
	(crate crate6)
	(surface crate6)
	(at crate6 depot3)
	(on crate6 pallet3)
	(crate crate7)
	(surface crate7)
	(at crate7 depot4)
	(on crate7 crate1)
	(crate crate8)
	(surface crate8)
	(at crate8 depot3)
	(on crate8 crate6)
	(crate crate9)
	(surface crate9)
	(at crate9 distributor1)
	(on crate9 crate5)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor0)
	(on crate10 pallet6)
	(crate crate11)
	(surface crate11)
	(at crate11 depot2)
	(on crate11 crate2)
	(crate crate12)
	(surface crate12)
	(at crate12 distributor1)
	(on crate12 crate9)
	(crate crate13)
	(surface crate13)
	(at crate13 distributor4)
	(on crate13 pallet10)
	(crate crate14)
	(surface crate14)
	(at crate14 depot4)
	(on crate14 crate7)
	(crate crate15)
	(surface crate15)
	(at crate15 depot3)
	(on crate15 crate8)
	(crate crate16)
	(surface crate16)
	(at crate16 distributor2)
	(on crate16 crate4)
	(crate crate17)
	(surface crate17)
	(at crate17 distributor3)
	(on crate17 crate3)
	(crate crate18)
	(surface crate18)
	(at crate18 depot4)
	(on crate18 crate14)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor2)
	(on crate19 crate16)
	(crate crate20)
	(surface crate20)
	(at crate20 distributor1)
	(on crate20 crate12)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor2)
	(on crate21 crate19)
	(crate crate22)
	(surface crate22)
	(at crate22 distributor4)
	(on crate22 crate13)
	(crate crate23)
	(surface crate23)
	(at crate23 distributor2)
	(on crate23 crate21)
	(crate crate24)
	(surface crate24)
	(at crate24 depot4)
	(on crate24 crate18)
	(crate crate25)
	(surface crate25)
	(at crate25 depot3)
	(on crate25 crate15)
	(crate crate26)
	(surface crate26)
	(at crate26 depot4)
	(on crate26 crate24)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor0)
	(on crate27 crate10)
	(crate crate28)
	(surface crate28)
	(at crate28 depot2)
	(on crate28 crate11)
	(crate crate29)
	(surface crate29)
	(at crate29 depot4)
	(on crate29 crate26)
	(crate crate30)
	(surface crate30)
	(at crate30 depot4)
	(on crate30 crate29)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor0)
	(on crate31 crate27)
	(crate crate32)
	(surface crate32)
	(at crate32 depot5)
	(on crate32 pallet5)
	(crate crate33)
	(surface crate33)
	(at crate33 distributor5)
	(on crate33 pallet11)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor5)
	(on crate34 crate33)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor5)
	(on crate35 crate34)
	(crate crate36)
	(surface crate36)
	(at crate36 depot0)
	(on crate36 pallet0)
	(crate crate37)
	(surface crate37)
	(at crate37 depot4)
	(on crate37 crate30)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor2)
	(on crate38 crate23)
	(crate crate39)
	(surface crate39)
	(at crate39 depot0)
	(on crate39 crate36)
	(crate crate40)
	(surface crate40)
	(at crate40 depot5)
	(on crate40 crate32)
	(crate crate41)
	(surface crate41)
	(at crate41 depot0)
	(on crate41 crate39)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor4)
	(on crate42 crate22)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor4)
	(on crate43 crate42)
	(crate crate44)
	(surface crate44)
	(at crate44 depot0)
	(on crate44 crate41)
	(crate crate45)
	(surface crate45)
	(at crate45 distributor2)
	(on crate45 crate38)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor5)
	(on crate46 crate35)
	(crate crate47)
	(surface crate47)
	(at crate47 distributor0)
	(on crate47 crate31)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place depot5)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
	(place distributor5)
)

(:goal (and
		(on crate0 crate4)
		(on crate1 crate46)
		(on crate2 crate40)
		(on crate3 crate43)
		(on crate4 pallet4)
		(on crate5 crate27)
		(on crate6 crate18)
		(on crate7 pallet5)
		(on crate8 pallet7)
		(on crate9 pallet8)
		(on crate10 pallet11)
		(on crate11 crate21)
		(on crate13 crate30)
		(on crate14 crate25)
		(on crate15 crate32)
		(on crate16 crate44)
		(on crate17 crate0)
		(on crate18 pallet6)
		(on crate20 crate9)
		(on crate21 pallet2)
		(on crate23 crate33)
		(on crate25 pallet0)
		(on crate26 crate5)
		(on crate27 pallet1)
		(on crate29 crate11)
		(on crate30 pallet9)
		(on crate31 crate45)
		(on crate32 crate13)
		(on crate33 crate47)
		(on crate34 crate8)
		(on crate37 crate29)
		(on crate38 pallet3)
		(on crate40 crate3)
		(on crate41 crate20)
		(on crate42 crate41)
		(on crate43 crate7)
		(on crate44 pallet10)
		(on crate45 crate6)
		(on crate46 crate26)
		(on crate47 crate38)
	)
))
