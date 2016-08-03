(define (problem depotprob60) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate27)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate40)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate45)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate33)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate36)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 depot5)
	(clear crate25)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 distributor0)
	(clear crate47)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor1)
	(clear crate43)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor2)
	(clear crate38)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor3)
	(clear crate42)
	(pallet pallet10)
	(surface pallet10)
	(at pallet10 distributor4)
	(clear crate46)
	(pallet pallet11)
	(surface pallet11)
	(at pallet11 distributor5)
	(clear pallet11)
	(truck truck0)
	(at truck0 depot4)
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
	(at crate0 depot0)
	(on crate0 pallet0)
	(crate crate1)
	(surface crate1)
	(at crate1 distributor0)
	(on crate1 pallet6)
	(crate crate2)
	(surface crate2)
	(at crate2 depot2)
	(on crate2 pallet2)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor0)
	(on crate3 crate1)
	(crate crate4)
	(surface crate4)
	(at crate4 depot0)
	(on crate4 crate0)
	(crate crate5)
	(surface crate5)
	(at crate5 distributor0)
	(on crate5 crate3)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor3)
	(on crate6 pallet9)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor1)
	(on crate7 pallet7)
	(crate crate8)
	(surface crate8)
	(at crate8 depot4)
	(on crate8 pallet4)
	(crate crate9)
	(surface crate9)
	(at crate9 depot0)
	(on crate9 crate4)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor3)
	(on crate10 crate6)
	(crate crate11)
	(surface crate11)
	(at crate11 distributor3)
	(on crate11 crate10)
	(crate crate12)
	(surface crate12)
	(at crate12 depot0)
	(on crate12 crate9)
	(crate crate13)
	(surface crate13)
	(at crate13 depot4)
	(on crate13 crate8)
	(crate crate14)
	(surface crate14)
	(at crate14 distributor0)
	(on crate14 crate5)
	(crate crate15)
	(surface crate15)
	(at crate15 depot0)
	(on crate15 crate12)
	(crate crate16)
	(surface crate16)
	(at crate16 depot3)
	(on crate16 pallet3)
	(crate crate17)
	(surface crate17)
	(at crate17 depot4)
	(on crate17 crate13)
	(crate crate18)
	(surface crate18)
	(at crate18 depot0)
	(on crate18 crate15)
	(crate crate19)
	(surface crate19)
	(at crate19 distributor3)
	(on crate19 crate11)
	(crate crate20)
	(surface crate20)
	(at crate20 distributor1)
	(on crate20 crate7)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor1)
	(on crate21 crate20)
	(crate crate22)
	(surface crate22)
	(at crate22 depot2)
	(on crate22 crate2)
	(crate crate23)
	(surface crate23)
	(at crate23 depot2)
	(on crate23 crate22)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor2)
	(on crate24 pallet8)
	(crate crate25)
	(surface crate25)
	(at crate25 depot5)
	(on crate25 pallet5)
	(crate crate26)
	(surface crate26)
	(at crate26 distributor2)
	(on crate26 crate24)
	(crate crate27)
	(surface crate27)
	(at crate27 depot0)
	(on crate27 crate18)
	(crate crate28)
	(surface crate28)
	(at crate28 depot4)
	(on crate28 crate17)
	(crate crate29)
	(surface crate29)
	(at crate29 depot1)
	(on crate29 pallet1)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor0)
	(on crate30 crate14)
	(crate crate31)
	(surface crate31)
	(at crate31 distributor0)
	(on crate31 crate30)
	(crate crate32)
	(surface crate32)
	(at crate32 distributor2)
	(on crate32 crate26)
	(crate crate33)
	(surface crate33)
	(at crate33 depot3)
	(on crate33 crate16)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor3)
	(on crate34 crate19)
	(crate crate35)
	(surface crate35)
	(at crate35 distributor4)
	(on crate35 pallet10)
	(crate crate36)
	(surface crate36)
	(at crate36 depot4)
	(on crate36 crate28)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor3)
	(on crate37 crate34)
	(crate crate38)
	(surface crate38)
	(at crate38 distributor2)
	(on crate38 crate32)
	(crate crate39)
	(surface crate39)
	(at crate39 depot1)
	(on crate39 crate29)
	(crate crate40)
	(surface crate40)
	(at crate40 depot1)
	(on crate40 crate39)
	(crate crate41)
	(surface crate41)
	(at crate41 distributor3)
	(on crate41 crate37)
	(crate crate42)
	(surface crate42)
	(at crate42 distributor3)
	(on crate42 crate41)
	(crate crate43)
	(surface crate43)
	(at crate43 distributor1)
	(on crate43 crate21)
	(crate crate44)
	(surface crate44)
	(at crate44 depot2)
	(on crate44 crate23)
	(crate crate45)
	(surface crate45)
	(at crate45 depot2)
	(on crate45 crate44)
	(crate crate46)
	(surface crate46)
	(at crate46 distributor4)
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
		(on crate0 crate39)
		(on crate1 pallet9)
		(on crate2 crate29)
		(on crate3 pallet10)
		(on crate4 crate17)
		(on crate5 crate42)
		(on crate6 crate32)
		(on crate7 crate4)
		(on crate9 crate33)
		(on crate10 crate6)
		(on crate11 crate2)
		(on crate12 pallet8)
		(on crate13 crate20)
		(on crate15 crate43)
		(on crate16 pallet11)
		(on crate17 crate12)
		(on crate18 crate11)
		(on crate19 crate31)
		(on crate20 crate3)
		(on crate21 pallet5)
		(on crate22 crate7)
		(on crate23 crate26)
		(on crate24 crate16)
		(on crate25 crate10)
		(on crate26 crate45)
		(on crate27 crate41)
		(on crate28 pallet6)
		(on crate29 pallet7)
		(on crate30 crate28)
		(on crate31 crate21)
		(on crate32 crate46)
		(on crate33 pallet0)
		(on crate36 crate1)
		(on crate37 crate25)
		(on crate38 crate30)
		(on crate39 crate19)
		(on crate40 crate44)
		(on crate41 crate9)
		(on crate42 pallet1)
		(on crate43 pallet4)
		(on crate44 pallet3)
		(on crate45 crate38)
		(on crate46 pallet2)
	)
))
