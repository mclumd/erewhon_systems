(define (problem depotprob130) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 - Distributor
	truck0 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate54)
	(at pallet1 depot1)
	(clear crate55)
	(at pallet2 depot2)
	(clear crate50)
	(at pallet3 depot3)
	(clear crate42)
	(at pallet4 depot4)
	(clear crate53)
	(at pallet5 depot5)
	(clear crate46)
	(at pallet6 depot6)
	(clear crate49)
	(at pallet7 distributor0)
	(clear crate32)
	(at pallet8 distributor1)
	(clear crate52)
	(at pallet9 distributor2)
	(clear crate34)
	(at pallet10 distributor3)
	(clear crate40)
	(at pallet11 distributor4)
	(clear crate23)
	(at pallet12 distributor5)
	(clear crate43)
	(at pallet13 distributor6)
	(clear crate48)
	(at truck0 distributor6)
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
	(at crate0 depot1)
	(on crate0 pallet1)
	(at crate1 distributor3)
	(on crate1 pallet10)
	(at crate2 distributor3)
	(on crate2 crate1)
	(at crate3 distributor0)
	(on crate3 pallet7)
	(at crate4 depot2)
	(on crate4 pallet2)
	(at crate5 distributor3)
	(on crate5 crate2)
	(at crate6 distributor3)
	(on crate6 crate5)
	(at crate7 distributor4)
	(on crate7 pallet11)
	(at crate8 distributor5)
	(on crate8 pallet12)
	(at crate9 depot3)
	(on crate9 pallet3)
	(at crate10 distributor5)
	(on crate10 crate8)
	(at crate11 depot1)
	(on crate11 crate0)
	(at crate12 depot0)
	(on crate12 pallet0)
	(at crate13 distributor5)
	(on crate13 crate10)
	(at crate14 depot1)
	(on crate14 crate11)
	(at crate15 depot0)
	(on crate15 crate12)
	(at crate16 distributor6)
	(on crate16 pallet13)
	(at crate17 depot3)
	(on crate17 crate9)
	(at crate18 depot0)
	(on crate18 crate15)
	(at crate19 depot5)
	(on crate19 pallet5)
	(at crate20 depot2)
	(on crate20 crate4)
	(at crate21 distributor1)
	(on crate21 pallet8)
	(at crate22 depot6)
	(on crate22 pallet6)
	(at crate23 distributor4)
	(on crate23 crate7)
	(at crate24 distributor6)
	(on crate24 crate16)
	(at crate25 depot6)
	(on crate25 crate22)
	(at crate26 distributor0)
	(on crate26 crate3)
	(at crate27 distributor6)
	(on crate27 crate24)
	(at crate28 depot6)
	(on crate28 crate25)
	(at crate29 distributor3)
	(on crate29 crate6)
	(at crate30 depot3)
	(on crate30 crate17)
	(at crate31 distributor3)
	(on crate31 crate29)
	(at crate32 distributor0)
	(on crate32 crate26)
	(at crate33 distributor5)
	(on crate33 crate13)
	(at crate34 distributor2)
	(on crate34 pallet9)
	(at crate35 distributor3)
	(on crate35 crate31)
	(at crate36 depot5)
	(on crate36 crate19)
	(at crate37 distributor3)
	(on crate37 crate35)
	(at crate38 distributor3)
	(on crate38 crate37)
	(at crate39 depot2)
	(on crate39 crate20)
	(at crate40 distributor3)
	(on crate40 crate38)
	(at crate41 distributor1)
	(on crate41 crate21)
	(at crate42 depot3)
	(on crate42 crate30)
	(at crate43 distributor5)
	(on crate43 crate33)
	(at crate44 depot6)
	(on crate44 crate28)
	(at crate45 depot4)
	(on crate45 pallet4)
	(at crate46 depot5)
	(on crate46 crate36)
	(at crate47 distributor6)
	(on crate47 crate27)
	(at crate48 distributor6)
	(on crate48 crate47)
	(at crate49 depot6)
	(on crate49 crate44)
	(at crate50 depot2)
	(on crate50 crate39)
	(at crate51 distributor1)
	(on crate51 crate41)
	(at crate52 distributor1)
	(on crate52 crate51)
	(at crate53 depot4)
	(on crate53 crate45)
	(at crate54 depot0)
	(on crate54 crate18)
	(at crate55 depot1)
	(on crate55 crate14)
)

(:goal (and
		(on crate0 crate41)
		(on crate1 crate6)
		(on crate2 pallet6)
		(on crate3 pallet12)
		(on crate4 crate36)
		(on crate6 crate2)
		(on crate7 crate20)
		(on crate8 crate35)
		(on crate9 crate21)
		(on crate10 crate51)
		(on crate11 crate40)
		(on crate12 pallet0)
		(on crate14 crate34)
		(on crate15 crate18)
		(on crate17 crate47)
		(on crate18 pallet5)
		(on crate19 pallet8)
		(on crate20 crate39)
		(on crate21 crate25)
		(on crate22 crate46)
		(on crate23 pallet4)
		(on crate24 pallet7)
		(on crate25 crate32)
		(on crate26 pallet13)
		(on crate27 crate55)
		(on crate29 crate48)
		(on crate31 crate49)
		(on crate32 crate19)
		(on crate33 crate37)
		(on crate34 crate12)
		(on crate35 crate45)
		(on crate36 crate8)
		(on crate37 crate0)
		(on crate38 pallet11)
		(on crate39 crate24)
		(on crate40 crate33)
		(on crate41 pallet1)
		(on crate42 crate10)
		(on crate43 pallet2)
		(on crate44 crate26)
		(on crate45 pallet9)
		(on crate46 crate3)
		(on crate47 crate54)
		(on crate48 pallet10)
		(on crate49 crate44)
		(on crate50 pallet3)
		(on crate51 crate27)
		(on crate52 crate38)
		(on crate53 crate1)
		(on crate54 crate43)
		(on crate55 crate53)
	)
))
