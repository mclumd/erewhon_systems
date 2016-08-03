(in-package :shop2)
(defproblem DEPOTPROB50 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE14) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE15) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DISTRIBUTOR0) (CLEAR CRATE12)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DISTRIBUTOR1)
  (CLEAR CRATE13) (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR0)
  (HOIST HOIST0) (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DISTRIBUTOR0) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DISTRIBUTOR1) (AVAILABLE HOIST3) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DEPOT0) (ON CRATE0 PALLET0)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DEPOT1)
  (ON CRATE1 PALLET1) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DEPOT1) (ON CRATE2 CRATE1) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT0) (ON CRATE3 CRATE0) (CRATE CRATE4) (SURFACE CRATE4)
  (AT CRATE4 DISTRIBUTOR0) (ON CRATE4 PALLET2) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DEPOT0) (ON CRATE5 CRATE3) (CRATE CRATE6)
  (SURFACE CRATE6) (AT CRATE6 DISTRIBUTOR0) (ON CRATE6 CRATE4)
  (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR0)
  (ON CRATE7 CRATE6) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DISTRIBUTOR0) (ON CRATE8 CRATE7) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DISTRIBUTOR0) (ON CRATE9 CRATE8)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR0)
  (ON CRATE10 CRATE9) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT0) (ON CRATE11 CRATE5) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR0) (ON CRATE12 CRATE10)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DISTRIBUTOR1)
  (ON CRATE13 PALLET3) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DEPOT0) (ON CRATE14 CRATE11) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DEPOT1) (ON CRATE15 CRATE2)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1)) 
 
 ;; goal 
((ON CRATE0 CRATE8) (ON CRATE1 PALLET1) (ON CRATE2 PALLET3)
 (ON CRATE4 CRATE7) (ON CRATE5 PALLET0) (ON CRATE6 CRATE2)
 (ON CRATE7 CRATE12) (ON CRATE8 CRATE4) (ON CRATE9 PALLET2)
 (ON CRATE10 CRATE1) (ON CRATE11 CRATE14) (ON CRATE12 CRATE5)
 (ON CRATE13 CRATE10) (ON CRATE14 CRATE13)))