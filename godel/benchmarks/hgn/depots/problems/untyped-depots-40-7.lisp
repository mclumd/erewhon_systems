(define (problem depotprob70) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 distributor0 distributor1 distributor2 distributor3 distributor4 truck0 pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 )
(:init
	(pallet pallet0)
	(surface pallet0)
	(at pallet0 depot0)
	(clear crate38)
	(pallet pallet1)
	(surface pallet1)
	(at pallet1 depot1)
	(clear crate35)
	(pallet pallet2)
	(surface pallet2)
	(at pallet2 depot2)
	(clear crate39)
	(pallet pallet3)
	(surface pallet3)
	(at pallet3 depot3)
	(clear crate23)
	(pallet pallet4)
	(surface pallet4)
	(at pallet4 depot4)
	(clear crate31)
	(pallet pallet5)
	(surface pallet5)
	(at pallet5 distributor0)
	(clear crate37)
	(pallet pallet6)
	(surface pallet6)
	(at pallet6 distributor1)
	(clear crate30)
	(pallet pallet7)
	(surface pallet7)
	(at pallet7 distributor2)
	(clear crate36)
	(pallet pallet8)
	(surface pallet8)
	(at pallet8 distributor3)
	(clear crate33)
	(pallet pallet9)
	(surface pallet9)
	(at pallet9 distributor4)
	(clear crate34)
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
	(at hoist5 distributor0)
	(available hoist5)
	(hoist hoist6)
	(at hoist6 distributor1)
	(available hoist6)
	(hoist hoist7)
	(at hoist7 distributor2)
	(available hoist7)
	(hoist hoist8)
	(at hoist8 distributor3)
	(available hoist8)
	(hoist hoist9)
	(at hoist9 distributor4)
	(available hoist9)
	(crate crate0)
	(surface crate0)
	(at crate0 distributor2)
	(on crate0 pallet7)
	(crate crate1)
	(surface crate1)
	(at crate1 depot4)
	(on crate1 pallet4)
	(crate crate2)
	(surface crate2)
	(at crate2 depot0)
	(on crate2 pallet0)
	(crate crate3)
	(surface crate3)
	(at crate3 distributor4)
	(on crate3 pallet9)
	(crate crate4)
	(surface crate4)
	(at crate4 depot1)
	(on crate4 pallet1)
	(crate crate5)
	(surface crate5)
	(at crate5 depot1)
	(on crate5 crate4)
	(crate crate6)
	(surface crate6)
	(at crate6 distributor2)
	(on crate6 crate0)
	(crate crate7)
	(surface crate7)
	(at crate7 distributor1)
	(on crate7 pallet6)
	(crate crate8)
	(surface crate8)
	(at crate8 depot0)
	(on crate8 crate2)
	(crate crate9)
	(surface crate9)
	(at crate9 depot0)
	(on crate9 crate8)
	(crate crate10)
	(surface crate10)
	(at crate10 distributor3)
	(on crate10 pallet8)
	(crate crate11)
	(surface crate11)
	(at crate11 distributor0)
	(on crate11 pallet5)
	(crate crate12)
	(surface crate12)
	(at crate12 depot0)
	(on crate12 crate9)
	(crate crate13)
	(surface crate13)
	(at crate13 depot4)
	(on crate13 crate1)
	(crate crate14)
	(surface crate14)
	(at crate14 depot0)
	(on crate14 crate12)
	(crate crate15)
	(surface crate15)
	(at crate15 distributor3)
	(on crate15 crate10)
	(crate crate16)
	(surface crate16)
	(at crate16 depot0)
	(on crate16 crate14)
	(crate crate17)
	(surface crate17)
	(at crate17 depot2)
	(on crate17 pallet2)
	(crate crate18)
	(surface crate18)
	(at crate18 distributor3)
	(on crate18 crate15)
	(crate crate19)
	(surface crate19)
	(at crate19 depot4)
	(on crate19 crate13)
	(crate crate20)
	(surface crate20)
	(at crate20 distributor4)
	(on crate20 crate3)
	(crate crate21)
	(surface crate21)
	(at crate21 distributor1)
	(on crate21 crate7)
	(crate crate22)
	(surface crate22)
	(at crate22 depot1)
	(on crate22 crate5)
	(crate crate23)
	(surface crate23)
	(at crate23 depot3)
	(on crate23 pallet3)
	(crate crate24)
	(surface crate24)
	(at crate24 distributor3)
	(on crate24 crate18)
	(crate crate25)
	(surface crate25)
	(at crate25 distributor2)
	(on crate25 crate6)
	(crate crate26)
	(surface crate26)
	(at crate26 depot0)
	(on crate26 crate16)
	(crate crate27)
	(surface crate27)
	(at crate27 distributor0)
	(on crate27 crate11)
	(crate crate28)
	(surface crate28)
	(at crate28 distributor0)
	(on crate28 crate27)
	(crate crate29)
	(surface crate29)
	(at crate29 depot0)
	(on crate29 crate26)
	(crate crate30)
	(surface crate30)
	(at crate30 distributor1)
	(on crate30 crate21)
	(crate crate31)
	(surface crate31)
	(at crate31 depot4)
	(on crate31 crate19)
	(crate crate32)
	(surface crate32)
	(at crate32 depot1)
	(on crate32 crate22)
	(crate crate33)
	(surface crate33)
	(at crate33 distributor3)
	(on crate33 crate24)
	(crate crate34)
	(surface crate34)
	(at crate34 distributor4)
	(on crate34 crate20)
	(crate crate35)
	(surface crate35)
	(at crate35 depot1)
	(on crate35 crate32)
	(crate crate36)
	(surface crate36)
	(at crate36 distributor2)
	(on crate36 crate25)
	(crate crate37)
	(surface crate37)
	(at crate37 distributor0)
	(on crate37 crate28)
	(crate crate38)
	(surface crate38)
	(at crate38 depot0)
	(on crate38 crate29)
	(crate crate39)
	(surface crate39)
	(at crate39 depot2)
	(on crate39 crate17)
	(place depot0)
	(place depot1)
	(place depot2)
	(place depot3)
	(place depot4)
	(place distributor0)
	(place distributor1)
	(place distributor2)
	(place distributor3)
	(place distributor4)
)

(:goal (and
		(on crate0 pallet5)
		(on crate1 crate10)
		(on crate2 crate12)
		(on crate3 crate39)
		(on crate5 crate8)
		(on crate6 pallet9)
		(on crate7 crate28)
		(on crate8 pallet2)
		(on crate9 crate20)
		(on crate10 crate24)
		(on crate11 pallet4)
		(on crate12 pallet6)
		(on crate13 crate16)
		(on crate14 pallet7)
		(on crate15 crate23)
		(on crate16 crate11)
		(on crate18 crate27)
		(on crate19 crate37)
		(on crate20 crate22)
		(on crate22 pallet3)
		(on crate23 crate25)
		(on crate24 crate6)
		(on crate25 crate0)
		(on crate26 crate30)
		(on crate27 crate33)
		(on crate28 crate26)
		(on crate29 pallet0)
		(on crate30 crate14)
		(on crate31 crate29)
		(on crate32 crate34)
		(on crate33 crate32)
		(on crate34 pallet1)
		(on crate35 crate3)
		(on crate37 pallet8)
		(on crate39 crate13)
	)
))
