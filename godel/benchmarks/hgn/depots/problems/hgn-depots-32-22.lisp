(in-package :shop2)
(defproblem DEPOTPROB220 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE27) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE15) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE28)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE25) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DISTRIBUTOR0) (CLEAR CRATE30) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DISTRIBUTOR1) (CLEAR CRATE23)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR2)
  (CLEAR CRATE31) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR3) (CLEAR CRATE21) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR0) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DEPOT3)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DISTRIBUTOR0)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DISTRIBUTOR1)
  (AVAILABLE HOIST5) (HOIST HOIST6) (AT HOIST6 DISTRIBUTOR2)
  (AVAILABLE HOIST6) (HOIST HOIST7) (AT HOIST7 DISTRIBUTOR3)
  (AVAILABLE HOIST7) (CRATE CRATE0) (SURFACE CRATE0) (AT CRATE0 DEPOT0)
  (ON CRATE0 PALLET0) (CRATE CRATE1) (SURFACE CRATE1)
  (AT CRATE1 DEPOT2) (ON CRATE1 PALLET2) (CRATE CRATE2)
  (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR1) (ON CRATE2 PALLET5)
  (CRATE CRATE3) (SURFACE CRATE3) (AT CRATE3 DEPOT2) (ON CRATE3 CRATE1)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DEPOT0) (ON CRATE4 CRATE0)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR0)
  (ON CRATE5 PALLET4) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DISTRIBUTOR3) (ON CRATE6 PALLET7) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR2) (ON CRATE7 PALLET6)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR3)
  (ON CRATE8 CRATE6) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DISTRIBUTOR2) (ON CRATE9 CRATE7) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR3) (ON CRATE10 CRATE8)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR2)
  (ON CRATE11 CRATE9) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DISTRIBUTOR0) (ON CRATE12 CRATE5) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DEPOT0) (ON CRATE13 CRATE4)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DEPOT1)
  (ON CRATE14 PALLET1) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DEPOT1) (ON CRATE15 CRATE14) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DEPOT2) (ON CRATE16 CRATE3)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR3)
  (ON CRATE17 CRATE10) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DEPOT0) (ON CRATE18 CRATE13) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR3) (ON CRATE19 CRATE17)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR0)
  (ON CRATE20 CRATE12) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DISTRIBUTOR3) (ON CRATE21 CRATE19) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DEPOT0) (ON CRATE22 CRATE18)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR1)
  (ON CRATE23 CRATE2) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DEPOT2) (ON CRATE24 CRATE16) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DEPOT3) (ON CRATE25 PALLET3)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DEPOT0)
  (ON CRATE26 CRATE22) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DEPOT0) (ON CRATE27 CRATE26) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DEPOT2) (ON CRATE28 CRATE24)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DISTRIBUTOR2)
  (ON CRATE29 CRATE11) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DISTRIBUTOR0) (ON CRATE30 CRATE20) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR2) (ON CRATE31 CRATE29)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)
  (PLACE DISTRIBUTOR3)) 
 
 ;; goal 
((ON CRATE1 CRATE27) (ON CRATE2 CRATE19) (ON CRATE4 CRATE10)
 (ON CRATE5 CRATE18) (ON CRATE6 CRATE9) (ON CRATE7 CRATE15)
 (ON CRATE9 CRATE2) (ON CRATE10 CRATE21) (ON CRATE11 CRATE7)
 (ON CRATE12 CRATE1) (ON CRATE13 PALLET6) (ON CRATE14 CRATE20)
 (ON CRATE15 CRATE16) (ON CRATE16 CRATE22) (ON CRATE17 PALLET2)
 (ON CRATE18 CRATE28) (ON CRATE19 CRATE25) (ON CRATE20 PALLET3)
 (ON CRATE21 PALLET1) (ON CRATE22 CRATE24) (ON CRATE24 CRATE13)
 (ON CRATE25 PALLET0) (ON CRATE27 CRATE14) (ON CRATE28 PALLET5)
 (ON CRATE30 CRATE6) (ON CRATE31 PALLET4)))