(in-package :shop2)
(defproblem DEPOTPROB130 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE20) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE23) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE11)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DISTRIBUTOR0)
  (CLEAR CRATE21) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DISTRIBUTOR1) (CLEAR CRATE14) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DISTRIBUTOR2) (CLEAR CRATE22)
  (TRUCK TRUCK0) (AT TRUCK0 DEPOT0) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DISTRIBUTOR0)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DISTRIBUTOR1)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DISTRIBUTOR2)
  (AVAILABLE HOIST5) (CRATE CRATE0) (SURFACE CRATE0) (AT CRATE0 DEPOT0)
  (ON CRATE0 PALLET0) (CRATE CRATE1) (SURFACE CRATE1)
  (AT CRATE1 DEPOT2) (ON CRATE1 PALLET2) (CRATE CRATE2)
  (SURFACE CRATE2) (AT CRATE2 DEPOT1) (ON CRATE2 PALLET1)
  (CRATE CRATE3) (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR0)
  (ON CRATE3 PALLET3) (CRATE CRATE4) (SURFACE CRATE4)
  (AT CRATE4 DISTRIBUTOR0) (ON CRATE4 CRATE3) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR2) (ON CRATE5 PALLET5)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DISTRIBUTOR1)
  (ON CRATE6 PALLET4) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DISTRIBUTOR0) (ON CRATE7 CRATE4) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DEPOT0) (ON CRATE8 CRATE0) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DEPOT0) (ON CRATE9 CRATE8)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR1)
  (ON CRATE10 CRATE6) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT2) (ON CRATE11 CRATE1) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR2) (ON CRATE12 CRATE5)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT1)
  (ON CRATE13 CRATE2) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR1) (ON CRATE14 CRATE10) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR0) (ON CRATE15 CRATE7)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR0)
  (ON CRATE16 CRATE15) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DISTRIBUTOR2) (ON CRATE17 CRATE12) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DEPOT1) (ON CRATE18 CRATE13)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT0)
  (ON CRATE19 CRATE9) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT0) (ON CRATE20 CRATE19) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR0) (ON CRATE21 CRATE16)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR2)
  (ON CRATE22 CRATE17) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DEPOT1) (ON CRATE23 CRATE18) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)) 
 
 ;; goal 
((ON CRATE0 CRATE16) (ON CRATE2 CRATE10) (ON CRATE3 PALLET3)
 (ON CRATE4 CRATE9) (ON CRATE5 CRATE2) (ON CRATE7 CRATE23)
 (ON CRATE8 CRATE18) (ON CRATE9 PALLET1) (ON CRATE10 PALLET5)
 (ON CRATE13 CRATE19) (ON CRATE14 CRATE0) (ON CRATE15 CRATE7)
 (ON CRATE16 CRATE17) (ON CRATE17 CRATE20) (ON CRATE18 CRATE4)
 (ON CRATE19 CRATE15) (ON CRATE20 PALLET4) (ON CRATE21 PALLET0)
 (ON CRATE22 CRATE14) (ON CRATE23 PALLET2)))