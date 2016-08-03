(define (problem depotprob170) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate39)
	(at pallet1 depot1)
	(clear crate31)
	(at pallet2 depot2)
	(clear crate33)
	(at pallet3 depot3)
	(clear crate41)
	(at pallet4 depot4)
	(clear crate45)
	(at pallet5 depot5)
	(clear crate53)
	(at pallet6 depot6)
	(clear crate43)
	(at pallet7 distributor0)
	(clear crate37)
	(at pallet8 distributor1)
	(clear crate38)
	(at pallet9 distributor2)
	(clear crate55)
	(at pallet10 distributor3)
	(clear crate54)
	(at pallet11 distributor4)
	(clear crate51)
	(at pallet12 distributor5)
	(clear crate35)
	(at pallet13 distributor6)
	(clear crate23)
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
	(at hoist6 depot6)
	(available hoist6)
	(at hoist7 distributor0)
	(available hoist7)
	(at hoist8 distributor1)
	(available hoist8)
	(at hoist9 distributor2)
	(available hoist9)
	(at hoist10 distributor3)
	(available hoist10)
	(at hoist11 distributor4)
	(available hoist11)
	(at hoist12 distributor5)
	(available hoist12)
	(at hoist13 distributor6)
	(available hoist13)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 depot4)
	(on crate1 pallet4)
	(at crate2 depot4)
	(on crate2 crate1)
	(at crate3 distributor6)
	(on crate3 pallet13)
	(at crate4 distributor4)
	(on crate4 pallet11)
	(at crate5 distributor6)
	(on crate5 crate3)
	(at crate6 distributor6)
	(on crate6 crate5)
	(at crate7 depot2)
	(on crate7 pallet2)
	(at crate8 distributor6)
	(on crate8 crate6)
	(at crate9 depot5)
	(on crate9 pallet5)
	(at crate10 distributor6)
	(on crate10 crate8)
	(at crate11 depot6)
	(on crate11 pallet6)
	(at crate12 depot2)
	(on crate12 crate7)
	(at crate13 depot1)
	(on crate13 pallet1)
	(at crate14 distributor2)
	(on crate14 pallet9)
	(at crate15 depot2)
	(on crate15 crate12)
	(at crate16 depot5)
	(on crate16 crate9)
	(at crate17 depot3)
	(on crate17 pallet3)
	(at crate18 depot5)
	(on crate18 crate16)
	(at crate19 distributor1)
	(on crate19 pallet8)
	(at crate20 depot0)
	(on crate20 crate0)
	(at crate21 depot3)
	(on crate21 crate17)
	(at crate22 distributor5)
	(on crate22 pallet12)
	(at crate23 distributor6)
	(on crate23 crate10)
	(at crate24 distributor4)
	(on crate24 crate4)
	(at crate25 depot5)
	(on crate25 crate18)
	(at crate26 distributor3)
	(on crate26 pallet10)
	(at crate27 distributor0)
	(on crate27 pallet7)
	(at crate28 distributor2)
	(on crate28 crate14)
	(at crate29 distributor0)
	(on crate29 crate27)
	(at crate30 depot0)
	(on crate30 crate20)
	(at crate31 depot1)
	(on crate31 crate13)
	(at crate32 depot3)
	(on crate32 crate21)
	(at crate33 depot2)
	(on crate33 crate15)
	(at crate34 distributor0)
	(on crate34 crate29)
	(at crate35 distributor5)
	(on crate35 crate22)
	(at crate36 depot4)
	(on crate36 crate2)
	(at crate37 distributor0)
	(on crate37 crate34)
	(at crate38 distributor1)
	(on crate38 crate19)
	(at crate39 depot0)
	(on crate39 crate30)
	(at crate40 distributor4)
	(on crate40 crate24)
	(at crate41 depot3)
	(on crate41 crate32)
	(at crate42 depot4)
	(on crate42 crate36)
	(at crate43 depot6)
	(on crate43 crate11)
	(at crate44 depot5)
	(on crate44 crate25)
	(at crate45 depot4)
	(on crate45 crate42)
	(at crate46 distributor3)
	(on crate46 crate26)
	(at crate47 distributor4)
	(on crate47 crate40)
	(at crate48 distributor3)
	(on crate48 crate46)
	(at crate49 distributor2)
	(on crate49 crate28)
	(at crate50 distributor4)
	(on crate50 crate47)
	(at crate51 distributor4)
	(on crate51 crate50)
	(at crate52 distributor2)
	(on crate52 crate49)
	(at crate53 depot5)
	(on crate53 crate44)
	(at crate54 distributor3)
	(on crate54 crate48)
	(at crate55 distributor2)
	(on crate55 crate52)
)

(:goal (and
		(on crate0 crate19)
		(on crate1 crate44)
		(on crate2 crate11)
		(on crate3 pallet8)
		(on crate4 pallet3)
		(on crate5 pallet10)
		(on crate6 crate43)
		(on crate7 pallet0)
		(on crate8 pallet9)
		(on crate9 pallet4)
		(on crate10 crate30)
		(on crate11 pallet7)
		(on crate12 pallet13)
		(on crate13 crate0)
		(on crate14 crate22)
		(on crate15 crate52)
		(on crate16 crate2)
		(on crate18 crate10)
		(on crate19 crate33)
		(on crate20 crate7)
		(on crate22 crate12)
		(on crate23 crate16)
		(on crate24 pallet12)
		(on crate25 pallet6)
		(on crate26 crate3)
		(on crate28 crate29)
		(on crate29 crate46)
		(on crate30 crate4)
		(on crate31 crate36)
		(on crate32 pallet5)
		(on crate33 pallet11)
		(on crate34 crate50)
		(on crate35 crate32)
		(on crate36 crate35)
		(on crate37 crate23)
		(on crate38 crate9)
		(on crate39 crate31)
		(on crate40 crate34)
		(on crate41 crate25)
		(on crate42 crate41)
		(on crate43 crate55)
		(on crate44 crate24)
		(on crate46 crate8)
		(on crate47 crate5)
		(on crate48 crate28)
		(on crate49 crate18)
		(on crate50 pallet1)
		(on crate52 crate40)
		(on crate55 crate42)
	)
))
