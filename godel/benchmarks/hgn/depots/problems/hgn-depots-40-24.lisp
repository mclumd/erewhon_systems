(in-package :shop2)
(defproblem DEPOTPROB240 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE30) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE34) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE23)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3) (CLEAR CRATE8)
  (PALLET PALLET4) (SURFACE PALLET4) (AT PALLET4 DEPOT4)
  (CLEAR CRATE33) (PALLET PALLET5) (SURFACE PALLET5)
  (AT PALLET5 DISTRIBUTOR0) (CLEAR CRATE38) (PALLET PALLET6)
  (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR1) (CLEAR CRATE39)
  (PALLET PALLET7) (SURFACE PALLET7) (AT PALLET7 DISTRIBUTOR2)
  (CLEAR CRATE36) (PALLET PALLET8) (SURFACE PALLET8)
  (AT PALLET8 DISTRIBUTOR3) (CLEAR CRATE35) (PALLET PALLET9)
  (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR4) (CLEAR CRATE29)
  (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR4) (HOIST HOIST0)
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
  (SURFACE CRATE0) (AT CRATE0 DEPOT3) (ON CRATE0 PALLET3)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR0)
  (ON CRATE1 PALLET5) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DISTRIBUTOR2) (ON CRATE2 PALLET7) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR3) (ON CRATE3 PALLET8)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR2)
  (ON CRATE4 CRATE2) (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT4)
  (ON CRATE5 PALLET4) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT0) (ON CRATE6 PALLET0) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DEPOT2) (ON CRATE7 PALLET2)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DEPOT3) (ON CRATE8 CRATE0)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DISTRIBUTOR0)
  (ON CRATE9 CRATE1) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT1) (ON CRATE10 PALLET1) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR2) (ON CRATE11 CRATE4)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR4)
  (ON CRATE12 PALLET9) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DEPOT2) (ON CRATE13 CRATE7) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR2) (ON CRATE14 CRATE11)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR4)
  (ON CRATE15 CRATE12) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DISTRIBUTOR3) (ON CRATE16 CRATE3) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DEPOT2) (ON CRATE17 CRATE13)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DEPOT2)
  (ON CRATE18 CRATE17) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DEPOT4) (ON CRATE19 CRATE5) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR1) (ON CRATE20 PALLET6)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR2)
  (ON CRATE21 CRATE14) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DEPOT2) (ON CRATE22 CRATE18) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DEPOT2) (ON CRATE23 CRATE22)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR2)
  (ON CRATE24 CRATE21) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DEPOT4) (ON CRATE25 CRATE19) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR3) (ON CRATE26 CRATE16)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR2)
  (ON CRATE27 CRATE24) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DISTRIBUTOR4) (ON CRATE28 CRATE15) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DISTRIBUTOR4) (ON CRATE29 CRATE28)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DEPOT0)
  (ON CRATE30 CRATE6) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DISTRIBUTOR3) (ON CRATE31 CRATE26) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DISTRIBUTOR0) (ON CRATE32 CRATE9)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DEPOT4)
  (ON CRATE33 CRATE25) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DEPOT1) (ON CRATE34 CRATE10) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DISTRIBUTOR3) (ON CRATE35 CRATE31)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DISTRIBUTOR2)
  (ON CRATE36 CRATE27) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR0) (ON CRATE37 CRATE32) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR0) (ON CRATE38 CRATE37)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR1)
  (ON CRATE39 CRATE20) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4)) 
 
 ;; goal 
((ON CRATE0 PALLET4) (ON CRATE1 CRATE36) (ON CRATE2 CRATE27)
 (ON CRATE4 CRATE12) (ON CRATE5 PALLET1) (ON CRATE6 CRATE4)
 (ON CRATE7 CRATE10) (ON CRATE8 PALLET0) (ON CRATE9 CRATE6)
 (ON CRATE10 PALLET6) (ON CRATE11 CRATE1) (ON CRATE12 PALLET5)
 (ON CRATE14 CRATE35) (ON CRATE15 PALLET9) (ON CRATE16 CRATE19)
 (ON CRATE18 PALLET3) (ON CRATE19 CRATE20) (ON CRATE20 PALLET7)
 (ON CRATE22 CRATE28) (ON CRATE23 CRATE7) (ON CRATE24 CRATE32)
 (ON CRATE25 CRATE8) (ON CRATE26 CRATE39) (ON CRATE27 CRATE23)
 (ON CRATE28 CRATE0) (ON CRATE29 CRATE11) (ON CRATE30 CRATE15)
 (ON CRATE31 CRATE22) (ON CRATE32 CRATE26) (ON CRATE33 CRATE37)
 (ON CRATE34 CRATE24) (ON CRATE35 PALLET8) (ON CRATE36 PALLET2)
 (ON CRATE37 CRATE31) (ON CRATE38 CRATE5) (ON CRATE39 CRATE14)))