(in-package :shop2)
(defproblem DEPOTPROB160 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE28) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE17) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE26)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE34) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE33) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DISTRIBUTOR0) (CLEAR CRATE37)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR1)
  (CLEAR CRATE39) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR2) (CLEAR CRATE38) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR3) (CLEAR CRATE27)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR4)
  (CLEAR CRATE32) (TRUCK TRUCK0) (AT TRUCK0 DEPOT1) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DEPOT2) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DEPOT3) (AVAILABLE HOIST3) (HOIST HOIST4)
  (AT HOIST4 DEPOT4) (AVAILABLE HOIST4) (HOIST HOIST5)
  (AT HOIST5 DISTRIBUTOR0) (AVAILABLE HOIST5) (HOIST HOIST6)
  (AT HOIST6 DISTRIBUTOR1) (AVAILABLE HOIST6) (HOIST HOIST7)
  (AT HOIST7 DISTRIBUTOR2) (AVAILABLE HOIST7) (HOIST HOIST8)
  (AT HOIST8 DISTRIBUTOR3) (AVAILABLE HOIST8) (HOIST HOIST9)
  (AT HOIST9 DISTRIBUTOR4) (AVAILABLE HOIST9) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DISTRIBUTOR4) (ON CRATE0 PALLET9)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DEPOT4)
  (ON CRATE1 PALLET4) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DEPOT1) (ON CRATE2 PALLET1) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DEPOT4) (ON CRATE3 CRATE1) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR2) (ON CRATE4 PALLET7)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR2)
  (ON CRATE5 CRATE4) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DISTRIBUTOR1) (ON CRATE6 PALLET6) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR4) (ON CRATE7 CRATE0)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR4)
  (ON CRATE8 CRATE7) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DISTRIBUTOR4) (ON CRATE9 CRATE8) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR1) (ON CRATE10 CRATE6)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR4)
  (ON CRATE11 CRATE9) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DEPOT1) (ON CRATE12 CRATE2) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DEPOT1) (ON CRATE13 CRATE12)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DEPOT2)
  (ON CRATE14 PALLET2) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DEPOT1) (ON CRATE15 CRATE13) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR2) (ON CRATE16 CRATE5)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DEPOT1)
  (ON CRATE17 CRATE15) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DEPOT4) (ON CRATE18 CRATE3) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR2) (ON CRATE19 CRATE16)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR2)
  (ON CRATE20 CRATE19) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DISTRIBUTOR0) (ON CRATE21 PALLET5) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR0) (ON CRATE22 CRATE21)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR2)
  (ON CRATE23 CRATE20) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DISTRIBUTOR3) (ON CRATE24 PALLET8) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR0) (ON CRATE25 CRATE22)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DEPOT2)
  (ON CRATE26 CRATE14) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DISTRIBUTOR3) (ON CRATE27 CRATE24) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DEPOT0) (ON CRATE28 PALLET0)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DEPOT3)
  (ON CRATE29 PALLET3) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DISTRIBUTOR2) (ON CRATE30 CRATE23) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR0) (ON CRATE31 CRATE25)
  (CRATE CRATE32) (SURFACE CRATE32) (AT CRATE32 DISTRIBUTOR4)
  (ON CRATE32 CRATE11) (CRATE CRATE33) (SURFACE CRATE33)
  (AT CRATE33 DEPOT4) (ON CRATE33 CRATE18) (CRATE CRATE34)
  (SURFACE CRATE34) (AT CRATE34 DEPOT3) (ON CRATE34 CRATE29)
  (CRATE CRATE35) (SURFACE CRATE35) (AT CRATE35 DISTRIBUTOR1)
  (ON CRATE35 CRATE10) (CRATE CRATE36) (SURFACE CRATE36)
  (AT CRATE36 DISTRIBUTOR1) (ON CRATE36 CRATE35) (CRATE CRATE37)
  (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR0) (ON CRATE37 CRATE31)
  (CRATE CRATE38) (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR2)
  (ON CRATE38 CRATE30) (CRATE CRATE39) (SURFACE CRATE39)
  (AT CRATE39 DISTRIBUTOR1) (ON CRATE39 CRATE36) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)
  (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)) 
 
 ;; goal 
((ON CRATE0 CRATE20) (ON CRATE1 CRATE22) (ON CRATE2 CRATE19)
 (ON CRATE3 CRATE12) (ON CRATE4 PALLET6) (ON CRATE5 CRATE29)
 (ON CRATE7 PALLET7) (ON CRATE8 PALLET5) (ON CRATE9 PALLET0)
 (ON CRATE10 CRATE39) (ON CRATE11 CRATE35) (ON CRATE12 CRATE28)
 (ON CRATE13 CRATE10) (ON CRATE15 CRATE18) (ON CRATE16 CRATE1)
 (ON CRATE17 CRATE8) (ON CRATE18 CRATE32) (ON CRATE19 PALLET2)
 (ON CRATE20 CRATE27) (ON CRATE21 CRATE5) (ON CRATE22 PALLET1)
 (ON CRATE23 PALLET9) (ON CRATE24 CRATE4) (ON CRATE27 PALLET8)
 (ON CRATE28 CRATE24) (ON CRATE29 CRATE23) (ON CRATE30 CRATE0)
 (ON CRATE31 CRATE11) (ON CRATE32 PALLET3) (ON CRATE33 CRATE15)
 (ON CRATE34 CRATE38) (ON CRATE35 PALLET4) (ON CRATE36 CRATE17)
 (ON CRATE37 CRATE3) (ON CRATE38 CRATE9) (ON CRATE39 CRATE16)))