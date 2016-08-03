(define (problem depotprob10) (:domain Depot)
(:objects
	depot0 - Depot
	distributor0 - Distributor
	truck0 - Truck
	pallet0 pallet1 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 - Crate
	hoist0 hoist1 - Hoist)
(:init 
  (pallet pallet0) (surface pallet0) (at pallet0 depot0) (clear crate7)
  (pallet pallet1) (surface pallet1) (at pallet1 distributor0)
  (clear crate4) (truck truck0) (at truck0 distributor0) (hoist hoist0)
  (at hoist0 depot0) (available hoist0) (hoist hoist1)
  (at hoist1 distributor0) (available hoist1) (crate crate0)
  (surface crate0) (at crate0 distributor0) (on crate0 pallet1)
  (crate crate1) (surface crate1) (at crate1 depot0)
  (on crate1 pallet0) (crate crate2) (surface crate2)
  (at crate2 distributor0) (on crate2 crate0) (crate crate3)
  (surface crate3) (at crate3 distributor0) (on crate3 crate2)
  (crate crate4) (surface crate4) (at crate4 distributor0)
  (on crate4 crate3) (crate crate5) (surface crate5) (at crate5 depot0)
  (on crate5 crate1) (crate crate6) (surface crate6) (at crate6 depot0)
  (on crate6 crate5) (crate crate7) (surface crate7) (at crate7 depot0)
  (on crate7 crate6) (place depot0) (place distributor0))

(:goal (and
		(on crate0 crate7)
		(on crate1 crate4)
		(on crate2 crate1)
		(on crate3 crate0)
		(on crate4 pallet1)
		(on crate5 crate3)
		(on crate7 pallet0)
	)
))