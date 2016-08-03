(in-package :shop2)
(defproblem DEPOTPROB60 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0) (CLEAR CRATE5)
  (PALLET PALLET1) (SURFACE PALLET1) (AT PALLET1 DISTRIBUTOR0)
  (CLEAR CRATE7) (TRUCK TRUCK0) (AT TRUCK0 DEPOT0) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DISTRIBUTOR0) (AVAILABLE HOIST1) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DISTRIBUTOR0) (ON CRATE0 PALLET1)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR0)
  (ON CRATE1 CRATE0) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DISTRIBUTOR0) (ON CRATE2 CRATE1) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DEPOT0) (ON CRATE3 PALLET0)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DEPOT0) (ON CRATE4 CRATE3)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT0) (ON CRATE5 CRATE4)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DISTRIBUTOR0)
  (ON CRATE6 CRATE2) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DISTRIBUTOR0) (ON CRATE7 CRATE6) (PLACE DEPOT0)
  (PLACE DISTRIBUTOR0)) 
 
 ;; goal 
((ON CRATE0 CRATE1) (ON CRATE1 PALLET1) (ON CRATE2 CRATE0)
 (ON CRATE3 CRATE4) (ON CRATE4 CRATE7) (ON CRATE6 CRATE2)
 (ON CRATE7 PALLET0)))