(define (problem depotprob20) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate27)
	(at pallet1 depot1)
	(clear pallet1)
	(at pallet2 depot2)
	(clear crate39)
	(at pallet3 depot3)
	(clear crate50)
	(at pallet4 depot4)
	(clear crate55)
	(at pallet5 depot5)
	(clear crate46)
	(at pallet6 depot6)
	(clear crate44)
	(at pallet7 distributor0)
	(clear crate51)
	(at pallet8 distributor1)
	(clear crate53)
	(at pallet9 distributor2)
	(clear crate21)
	(at pallet10 distributor3)
	(clear crate38)
	(at pallet11 distributor4)
	(clear crate34)
	(at pallet12 distributor5)
	(clear crate54)
	(at pallet13 distributor6)
	(clear crate48)
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
	(at crate2 distributor6)
	(on crate2 pallet13)
	(at crate3 distributor1)
	(on crate3 pallet8)
	(at crate4 depot3)
	(on crate4 pallet3)
	(at crate5 distributor2)
	(on crate5 pallet9)
	(at crate6 distributor1)
	(on crate6 crate3)
	(at crate7 distributor6)
	(on crate7 crate2)
	(at crate8 distributor1)
	(on crate8 crate6)
	(at crate9 distributor3)
	(on crate9 pallet10)
	(at crate10 depot4)
	(on crate10 crate1)
	(at crate11 depot3)
	(on crate11 crate4)
	(at crate12 depot0)
	(on crate12 crate0)
	(at crate13 depot4)
	(on crate13 crate10)
	(at crate14 distributor5)
	(on crate14 pallet12)
	(at crate15 depot6)
	(on crate15 pallet6)
	(at crate16 distributor5)
	(on crate16 crate14)
	(at crate17 distributor6)
	(on crate17 crate7)
	(at crate18 distributor0)
	(on crate18 pallet7)
	(at crate19 depot3)
	(on crate19 crate11)
	(at crate20 distributor6)
	(on crate20 crate17)
	(at crate21 distributor2)
	(on crate21 crate5)
	(at crate22 distributor5)
	(on crate22 crate16)
	(at crate23 distributor3)
	(on crate23 crate9)
	(at crate24 distributor6)
	(on crate24 crate20)
	(at crate25 depot6)
	(on crate25 crate15)
	(at crate26 depot3)
	(on crate26 crate19)
	(at crate27 depot0)
	(on crate27 crate12)
	(at crate28 distributor0)
	(on crate28 crate18)
	(at crate29 distributor6)
	(on crate29 crate24)
	(at crate30 distributor3)
	(on crate30 crate23)
	(at crate31 depot5)
	(on crate31 pallet5)
	(at crate32 depot2)
	(on crate32 pallet2)
	(at crate33 distributor0)
	(on crate33 crate28)
	(at crate34 distributor4)
	(on crate34 pallet11)
	(at crate35 depot6)
	(on crate35 crate25)
	(at crate36 distributor3)
	(on crate36 crate30)
	(at crate37 depot4)
	(on crate37 crate13)
	(at crate38 distributor3)
	(on crate38 crate36)
	(at crate39 depot2)
	(on crate39 crate32)
	(at crate40 depot6)
	(on crate40 crate35)
	(at crate41 distributor6)
	(on crate41 crate29)
	(at crate42 depot4)
	(on crate42 crate37)
	(at crate43 distributor6)
	(on crate43 crate41)
	(at crate44 depot6)
	(on crate44 crate40)
	(at crate45 depot3)
	(on crate45 crate26)
	(at crate46 depot5)
	(on crate46 crate31)
	(at crate47 distributor5)
	(on crate47 crate22)
	(at crate48 distributor6)
	(on crate48 crate43)
	(at crate49 depot4)
	(on crate49 crate42)
	(at crate50 depot3)
	(on crate50 crate45)
	(at crate51 distributor0)
	(on crate51 crate33)
	(at crate52 distributor5)
	(on crate52 crate47)
	(at crate53 distributor1)
	(on crate53 crate8)
	(at crate54 distributor5)
	(on crate54 crate52)
	(at crate55 depot4)
	(on crate55 crate49)
)

(:goal (and
		(on crate0 crate33)
		(on crate2 pallet7)
		(on crate3 crate9)
		(on crate4 crate21)
		(on crate5 crate32)
		(on crate8 crate22)
		(on crate9 crate19)
		(on crate11 pallet1)
		(on crate12 pallet2)
		(on crate13 crate49)
		(on crate14 crate51)
		(on crate15 pallet0)
		(on crate16 crate8)
		(on crate17 crate18)
		(on crate18 crate11)
		(on crate19 pallet5)
		(on crate20 crate23)
		(on crate21 crate2)
		(on crate22 pallet12)
		(on crate23 crate50)
		(on crate24 crate29)
		(on crate25 crate43)
		(on crate26 crate45)
		(on crate27 pallet10)
		(on crate28 pallet11)
		(on crate29 crate48)
		(on crate30 crate40)
		(on crate31 crate30)
		(on crate32 crate14)
		(on crate33 crate16)
		(on crate35 crate47)
		(on crate36 crate53)
		(on crate37 crate24)
		(on crate38 crate31)
		(on crate39 pallet8)
		(on crate40 pallet4)
		(on crate41 pallet13)
		(on crate42 pallet3)
		(on crate43 crate46)
		(on crate44 crate42)
		(on crate45 crate27)
		(on crate46 crate54)
		(on crate47 crate41)
		(on crate48 crate12)
		(on crate49 crate17)
		(on crate50 crate35)
		(on crate51 pallet6)
		(on crate53 pallet9)
		(on crate54 crate28)
		(on crate55 crate20)
	)
))