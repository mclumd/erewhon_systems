(in-package :shop2)
(defproblem DEPOTPROB80 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE23) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE20) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE10)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DISTRIBUTOR0)
  (CLEAR CRATE21) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DISTRIBUTOR1) (CLEAR CRATE18) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DISTRIBUTOR2) (CLEAR CRATE22)
  (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR0) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DEPOT2) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DISTRIBUTOR0) (AVAILABLE HOIST3) (HOIST HOIST4)
  (AT HOIST4 DISTRIBUTOR1) (AVAILABLE HOIST4) (HOIST HOIST5)
  (AT HOIST5 DISTRIBUTOR2) (AVAILABLE HOIST5) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DISTRIBUTOR2) (ON CRATE0 PALLET5)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR1)
  (ON CRATE1 PALLET4) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DISTRIBUTOR0) (ON CRATE2 PALLET3) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR0) (ON CRATE3 CRATE2)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DEPOT2)
  (ON CRATE4 PALLET2) (CRATE CRATE5) (SURFACE CRATE5)
  (AT CRATE5 DISTRIBUTOR0) (ON CRATE5 CRATE3) (CRATE CRATE6)
  (SURFACE CRATE6) (AT CRATE6 DEPOT2) (ON CRATE6 CRATE4) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DEPOT1) (ON CRATE7 PALLET1)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DEPOT2) (ON CRATE8 CRATE6)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DISTRIBUTOR2)
  (ON CRATE9 CRATE0) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT2) (ON CRATE10 CRATE8) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DEPOT1) (ON CRATE11 CRATE7)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DEPOT0)
  (ON CRATE12 PALLET0) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR0) (ON CRATE13 CRATE5) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR1) (ON CRATE14 CRATE1)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR1)
  (ON CRATE15 CRATE14) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DISTRIBUTOR1) (ON CRATE16 CRATE15) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR1) (ON CRATE17 CRATE16)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR1)
  (ON CRATE18 CRATE17) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DISTRIBUTOR0) (ON CRATE19 CRATE13) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DEPOT1) (ON CRATE20 CRATE11)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR0)
  (ON CRATE21 CRATE19) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR2) (ON CRATE22 CRATE9) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DEPOT0) (ON CRATE23 CRATE12)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)) 
 
 ;; goal 
((ON CRATE0 CRATE18) (ON CRATE1 CRATE2) (ON CRATE2 CRATE16)
 (ON CRATE3 CRATE8) (ON CRATE4 CRATE12) (ON CRATE5 PALLET5)
 (ON CRATE6 PALLET1) (ON CRATE7 CRATE3) (ON CRATE8 CRATE20)
 (ON CRATE10 CRATE21) (ON CRATE11 CRATE10) (ON CRATE12 CRATE6)
 (ON CRATE13 PALLET3) (ON CRATE15 CRATE19) (ON CRATE16 CRATE17)
 (ON CRATE17 CRATE22) (ON CRATE18 PALLET4) (ON CRATE19 CRATE0)
 (ON CRATE20 CRATE5) (ON CRATE21 CRATE4) (ON CRATE22 PALLET0)
 (ON CRATE23 PALLET2)))