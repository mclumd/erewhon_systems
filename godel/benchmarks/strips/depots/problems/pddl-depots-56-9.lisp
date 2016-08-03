(define (problem depotprob90) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate55)
	(at pallet1 depot1)
	(clear crate45)
	(at pallet2 depot2)
	(clear crate54)
	(at pallet3 depot3)
	(clear crate53)
	(at pallet4 depot4)
	(clear crate52)
	(at pallet5 depot5)
	(clear crate35)
	(at pallet6 depot6)
	(clear crate48)
	(at pallet7 distributor0)
	(clear crate44)
	(at pallet8 distributor1)
	(clear crate43)
	(at pallet9 distributor2)
	(clear crate51)
	(at pallet10 distributor3)
	(clear crate42)
	(at pallet11 distributor4)
	(clear crate3)
	(at pallet12 distributor5)
	(clear crate36)
	(at pallet13 distributor6)
	(clear crate49)
	(at truck0 distributor5)
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
	(at crate1 depot5)
	(on crate1 pallet5)
	(at crate2 depot0)
	(on crate2 crate0)
	(at crate3 distributor4)
	(on crate3 pallet11)
	(at crate4 distributor0)
	(on crate4 pallet7)
	(at crate5 depot3)
	(on crate5 pallet3)
	(at crate6 distributor1)
	(on crate6 pallet8)
	(at crate7 depot4)
	(on crate7 pallet4)
	(at crate8 distributor5)
	(on crate8 pallet12)
	(at crate9 depot1)
	(on crate9 pallet1)
	(at crate10 distributor2)
	(on crate10 pallet9)
	(at crate11 depot0)
	(on crate11 crate2)
	(at crate12 distributor0)
	(on crate12 crate4)
	(at crate13 depot0)
	(on crate13 crate11)
	(at crate14 depot1)
	(on crate14 crate9)
	(at crate15 distributor6)
	(on crate15 pallet13)
	(at crate16 distributor0)
	(on crate16 crate12)
	(at crate17 distributor2)
	(on crate17 crate10)
	(at crate18 depot6)
	(on crate18 pallet6)
	(at crate19 depot4)
	(on crate19 crate7)
	(at crate20 depot3)
	(on crate20 crate5)
	(at crate21 distributor1)
	(on crate21 crate6)
	(at crate22 depot2)
	(on crate22 pallet2)
	(at crate23 depot3)
	(on crate23 crate20)
	(at crate24 distributor3)
	(on crate24 pallet10)
	(at crate25 depot3)
	(on crate25 crate23)
	(at crate26 distributor5)
	(on crate26 crate8)
	(at crate27 distributor2)
	(on crate27 crate17)
	(at crate28 depot1)
	(on crate28 crate14)
	(at crate29 distributor0)
	(on crate29 crate16)
	(at crate30 distributor6)
	(on crate30 crate15)
	(at crate31 depot4)
	(on crate31 crate19)
	(at crate32 distributor5)
	(on crate32 crate26)
	(at crate33 depot0)
	(on crate33 crate13)
	(at crate34 depot6)
	(on crate34 crate18)
	(at crate35 depot5)
	(on crate35 crate1)
	(at crate36 distributor5)
	(on crate36 crate32)
	(at crate37 distributor1)
	(on crate37 crate21)
	(at crate38 distributor6)
	(on crate38 crate30)
	(at crate39 depot1)
	(on crate39 crate28)
	(at crate40 depot3)
	(on crate40 crate25)
	(at crate41 depot1)
	(on crate41 crate39)
	(at crate42 distributor3)
	(on crate42 crate24)
	(at crate43 distributor1)
	(on crate43 crate37)
	(at crate44 distributor0)
	(on crate44 crate29)
	(at crate45 depot1)
	(on crate45 crate41)
	(at crate46 distributor2)
	(on crate46 crate27)
	(at crate47 distributor6)
	(on crate47 crate38)
	(at crate48 depot6)
	(on crate48 crate34)
	(at crate49 distributor6)
	(on crate49 crate47)
	(at crate50 depot3)
	(on crate50 crate40)
	(at crate51 distributor2)
	(on crate51 crate46)
	(at crate52 depot4)
	(on crate52 crate31)
	(at crate53 depot3)
	(on crate53 crate50)
	(at crate54 depot2)
	(on crate54 crate22)
	(at crate55 depot0)
	(on crate55 crate33)
)

(:goal (and
		(on crate0 crate44)
		(on crate1 crate49)
		(on crate3 pallet12)
		(on crate5 crate36)
		(on crate6 crate55)
		(on crate7 pallet7)
		(on crate8 crate47)
		(on crate9 crate41)
		(on crate10 pallet5)
		(on crate11 crate6)
		(on crate12 crate54)
		(on crate13 crate29)
		(on crate15 crate19)
		(on crate17 crate25)
		(on crate18 pallet2)
		(on crate19 crate37)
		(on crate20 pallet3)
		(on crate21 pallet6)
		(on crate22 crate48)
		(on crate23 pallet10)
		(on crate24 crate40)
		(on crate25 crate26)
		(on crate26 crate13)
		(on crate27 crate5)
		(on crate28 pallet13)
		(on crate29 crate52)
		(on crate31 pallet4)
		(on crate32 crate51)
		(on crate34 crate7)
		(on crate35 crate53)
		(on crate36 crate20)
		(on crate37 crate10)
		(on crate38 pallet11)
		(on crate39 crate42)
		(on crate40 crate11)
		(on crate41 crate27)
		(on crate42 crate43)
		(on crate43 pallet9)
		(on crate44 crate15)
		(on crate45 crate23)
		(on crate46 crate8)
		(on crate47 crate18)
		(on crate48 crate50)
		(on crate49 crate34)
		(on crate50 pallet8)
		(on crate51 pallet0)
		(on crate52 crate28)
		(on crate53 crate32)
		(on crate54 crate21)
		(on crate55 pallet1)
	)
))