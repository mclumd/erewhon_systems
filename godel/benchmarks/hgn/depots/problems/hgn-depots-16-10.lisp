(in-package :shop2)
(defproblem DEPOTPROB100 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE12) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE7) (PALLET PALLET2) (SURFACE PALLET2)
  (AT PALLET2 DISTRIBUTOR0) (CLEAR PALLET2) (PALLET PALLET3)
  (SURFACE PALLET3) (AT PALLET3 DISTRIBUTOR1) (CLEAR CRATE15)
  (TRUCK TRUCK0) (AT TRUCK0 DEPOT0) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DISTRIBUTOR0)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DISTRIBUTOR1)
  (AVAILABLE HOIST3) (CRATE CRATE0) (SURFACE CRATE0) (AT CRATE0 DEPOT0)
  (ON CRATE0 PALLET0) (CRATE CRATE1) (SURFACE CRATE1)
  (AT CRATE1 DEPOT1) (ON CRATE1 PALLET1) (CRATE CRATE2)
  (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR1) (ON CRATE2 PALLET3)
  (CRATE CRATE3) (SURFACE CRATE3) (AT CRATE3 DEPOT1) (ON CRATE3 CRATE1)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DEPOT1) (ON CRATE4 CRATE3)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT1) (ON CRATE5 CRATE4)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DEPOT1) (ON CRATE6 CRATE5)
  (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DEPOT1) (ON CRATE7 CRATE6)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR1)
  (ON CRATE8 CRATE2) (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT0)
  (ON CRATE9 CRATE0) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT0) (ON CRATE10 CRATE9) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DEPOT0) (ON CRATE11 CRATE10)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DEPOT0)
  (ON CRATE12 CRATE11) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR1) (ON CRATE13 CRATE8) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR1) (ON CRATE14 CRATE13)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR1)
  (ON CRATE15 CRATE14) (PLACE DEPOT0) (PLACE DEPOT1)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)) 
 
 ;; goal 
((ON CRATE0 CRATE11) (ON CRATE2 CRATE8) (ON CRATE3 CRATE12)
 (ON CRATE4 PALLET1) (ON CRATE5 CRATE14) (ON CRATE6 CRATE0)
 (ON CRATE7 CRATE10) (ON CRATE8 CRATE7) (ON CRATE9 CRATE5)
 (ON CRATE10 CRATE15) (ON CRATE11 CRATE13) (ON CRATE12 PALLET2)
 (ON CRATE13 PALLET0) (ON CRATE14 CRATE3) (ON CRATE15 CRATE4)))