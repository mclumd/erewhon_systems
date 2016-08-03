(in-package :shop2)
(defproblem DEPOTPROB250 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE38) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE28) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE20)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE32) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE39) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DISTRIBUTOR0) (CLEAR CRATE35)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR1)
  (CLEAR CRATE37) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR2) (CLEAR CRATE26) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR3) (CLEAR CRATE33)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR4)
  (CLEAR CRATE36) (TRUCK TRUCK0) (AT TRUCK0 DEPOT0) (HOIST HOIST0)
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
  (SURFACE CRATE0) (AT CRATE0 DEPOT4) (ON CRATE0 PALLET4)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR2)
  (ON CRATE1 PALLET7) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DEPOT4) (ON CRATE2 CRATE0) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT3) (ON CRATE3 PALLET3) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT3) (ON CRATE4 CRATE3) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DEPOT4) (ON CRATE5 CRATE2) (CRATE CRATE6)
  (SURFACE CRATE6) (AT CRATE6 DEPOT1) (ON CRATE6 PALLET1)
  (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR1)
  (ON CRATE7 PALLET6) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DISTRIBUTOR1) (ON CRATE8 CRATE7) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DEPOT3) (ON CRATE9 CRATE4)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR2)
  (ON CRATE10 CRATE1) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT0) (ON CRATE11 PALLET0) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR0) (ON CRATE12 PALLET5)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT1)
  (ON CRATE13 CRATE6) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR1) (ON CRATE14 CRATE8) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR4) (ON CRATE15 PALLET9)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR2)
  (ON CRATE16 CRATE10) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DISTRIBUTOR3) (ON CRATE17 PALLET8) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DEPOT4) (ON CRATE18 CRATE5)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT3)
  (ON CRATE19 CRATE9) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT2) (ON CRATE20 PALLET2) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DEPOT4) (ON CRATE21 CRATE18)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DEPOT4)
  (ON CRATE22 CRATE21) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DISTRIBUTOR1) (ON CRATE23 CRATE14) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DEPOT4) (ON CRATE24 CRATE22)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DEPOT3)
  (ON CRATE25 CRATE19) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DISTRIBUTOR2) (ON CRATE26 CRATE16) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR3) (ON CRATE27 CRATE17)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DEPOT1)
  (ON CRATE28 CRATE13) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DISTRIBUTOR3) (ON CRATE29 CRATE27) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR4) (ON CRATE30 CRATE15)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR4)
  (ON CRATE31 CRATE30) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DEPOT3) (ON CRATE32 CRATE25) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR3) (ON CRATE33 CRATE29)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR4)
  (ON CRATE34 CRATE31) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DISTRIBUTOR0) (ON CRATE35 CRATE12) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DISTRIBUTOR4) (ON CRATE36 CRATE34)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR1)
  (ON CRATE37 CRATE23) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DEPOT0) (ON CRATE38 CRATE11) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DEPOT4) (ON CRATE39 CRATE24)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3)
  (PLACE DEPOT4) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)) 
 
 ;; goal 
((ON CRATE0 CRATE18) (ON CRATE1 CRATE33) (ON CRATE2 CRATE23)
 (ON CRATE3 CRATE7) (ON CRATE4 CRATE39) (ON CRATE5 PALLET1)
 (ON CRATE6 CRATE13) (ON CRATE7 CRATE15) (ON CRATE8 CRATE25)
 (ON CRATE9 PALLET5) (ON CRATE11 PALLET0) (ON CRATE12 CRATE1)
 (ON CRATE13 PALLET9) (ON CRATE14 CRATE35) (ON CRATE15 CRATE31)
 (ON CRATE16 CRATE32) (ON CRATE18 CRATE6) (ON CRATE19 PALLET3)
 (ON CRATE20 CRATE11) (ON CRATE21 PALLET4) (ON CRATE22 PALLET7)
 (ON CRATE23 CRATE4) (ON CRATE24 CRATE16) (ON CRATE25 PALLET2)
 (ON CRATE27 CRATE24) (ON CRATE28 PALLET8) (ON CRATE30 CRATE3)
 (ON CRATE31 PALLET6) (ON CRATE32 CRATE28) (ON CRATE33 CRATE20)
 (ON CRATE34 CRATE21) (ON CRATE35 CRATE8) (ON CRATE36 CRATE5)
 (ON CRATE39 CRATE36)))