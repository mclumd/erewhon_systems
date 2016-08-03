(define (problem depotprob60) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate27)
	(at pallet1 depot1)
	(clear crate40)
	(at pallet2 depot2)
	(clear crate45)
	(at pallet3 depot3)
	(clear crate33)
	(at pallet4 depot4)
	(clear crate36)
	(at pallet5 depot5)
	(clear crate25)
	(at pallet6 distributor0)
	(clear crate47)
	(at pallet7 distributor1)
	(clear crate43)
	(at pallet8 distributor2)
	(clear crate38)
	(at pallet9 distributor3)
	(clear crate42)
	(at pallet10 distributor4)
	(clear crate46)
	(at pallet11 distributor5)
	(clear pallet11)
	(at truck0 depot4)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 depot2)
	(available hoist2)
	(at hoist3 depot3)
	(available hoist3)
	(at hoist4 depot4)
	(available hoist4)
	(at hoist5 depot5)
	(available hoist5)
	(at hoist6 distributor0)
	(available hoist6)
	(at hoist7 distributor1)
	(available hoist7)
	(at hoist8 distributor2)
	(available hoist8)
	(at hoist9 distributor3)
	(available hoist9)
	(at hoist10 distributor4)
	(available hoist10)
	(at hoist11 distributor5)
	(available hoist11)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 distributor0)
	(on crate1 pallet6)
	(at crate2 depot2)
	(on crate2 pallet2)
	(at crate3 distributor0)
	(on crate3 crate1)
	(at crate4 depot0)
	(on crate4 crate0)
	(at crate5 distributor0)
	(on crate5 crate3)
	(at crate6 distributor3)
	(on crate6 pallet9)
	(at crate7 distributor1)
	(on crate7 pallet7)
	(at crate8 depot4)
	(on crate8 pallet4)
	(at crate9 depot0)
	(on crate9 crate4)
	(at crate10 distributor3)
	(on crate10 crate6)
	(at crate11 distributor3)
	(on crate11 crate10)
	(at crate12 depot0)
	(on crate12 crate9)
	(at crate13 depot4)
	(on crate13 crate8)
	(at crate14 distributor0)
	(on crate14 crate5)
	(at crate15 depot0)
	(on crate15 crate12)
	(at crate16 depot3)
	(on crate16 pallet3)
	(at crate17 depot4)
	(on crate17 crate13)
	(at crate18 depot0)
	(on crate18 crate15)
	(at crate19 distributor3)
	(on crate19 crate11)
	(at crate20 distributor1)
	(on crate20 crate7)
	(at crate21 distributor1)
	(on crate21 crate20)
	(at crate22 depot2)
	(on crate22 crate2)
	(at crate23 depot2)
	(on crate23 crate22)
	(at crate24 distributor2)
	(on crate24 pallet8)
	(at crate25 depot5)
	(on crate25 pallet5)
	(at crate26 distributor2)
	(on crate26 crate24)
	(at crate27 depot0)
	(on crate27 crate18)
	(at crate28 depot4)
	(on crate28 crate17)
	(at crate29 depot1)
	(on crate29 pallet1)
	(at crate30 distributor0)
	(on crate30 crate14)
	(at crate31 distributor0)
	(on crate31 crate30)
	(at crate32 distributor2)
	(on crate32 crate26)
	(at crate33 depot3)
	(on crate33 crate16)
	(at crate34 distributor3)
	(on crate34 crate19)
	(at crate35 distributor4)
	(on crate35 pallet10)
	(at crate36 depot4)
	(on crate36 crate28)
	(at crate37 distributor3)
	(on crate37 crate34)
	(at crate38 distributor2)
	(on crate38 crate32)
	(at crate39 depot1)
	(on crate39 crate29)
	(at crate40 depot1)
	(on crate40 crate39)
	(at crate41 distributor3)
	(on crate41 crate37)
	(at crate42 distributor3)
	(on crate42 crate41)
	(at crate43 distributor1)
	(on crate43 crate21)
	(at crate44 depot2)
	(on crate44 crate23)
	(at crate45 depot2)
	(on crate45 crate44)
	(at crate46 distributor4)
	(on crate46 crate35)
	(at crate47 distributor0)
	(on crate47 crate31)
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