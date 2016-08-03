(in-package :shop2)
(defproblem DEPOTPROB30 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE37) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE43) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE41)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE35) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE9) (PALLET PALLET5) (SURFACE PALLET5)
  (AT PALLET5 DEPOT5) (CLEAR CRATE45) (PALLET PALLET6)
  (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR0) (CLEAR CRATE32)
  (PALLET PALLET7) (SURFACE PALLET7) (AT PALLET7 DISTRIBUTOR1)
  (CLEAR CRATE38) (PALLET PALLET8) (SURFACE PALLET8)
  (AT PALLET8 DISTRIBUTOR2) (CLEAR CRATE47) (PALLET PALLET9)
  (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR3) (CLEAR CRATE40)
  (PALLET PALLET10) (SURFACE PALLET10) (AT PALLET10 DISTRIBUTOR4)
  (CLEAR CRATE39) (PALLET PALLET11) (SURFACE PALLET11)
  (AT PALLET11 DISTRIBUTOR5) (CLEAR CRATE46) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR2) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DEPOT3)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DEPOT4)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DEPOT5)
  (AVAILABLE HOIST5) (HOIST HOIST6) (AT HOIST6 DISTRIBUTOR0)
  (AVAILABLE HOIST6) (HOIST HOIST7) (AT HOIST7 DISTRIBUTOR1)
  (AVAILABLE HOIST7) (HOIST HOIST8) (AT HOIST8 DISTRIBUTOR2)
  (AVAILABLE HOIST8) (HOIST HOIST9) (AT HOIST9 DISTRIBUTOR3)
  (AVAILABLE HOIST9) (HOIST HOIST10) (AT HOIST10 DISTRIBUTOR4)
  (AVAILABLE HOIST10) (HOIST HOIST11) (AT HOIST11 DISTRIBUTOR5)
  (AVAILABLE HOIST11) (CRATE CRATE0) (SURFACE CRATE0)
  (AT CRATE0 DISTRIBUTOR1) (ON CRATE0 PALLET7) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR4) (ON CRATE1 PALLET10)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT3)
  (ON CRATE2 PALLET3) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DISTRIBUTOR0) (ON CRATE3 PALLET6) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT5) (ON CRATE4 PALLET5)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT4)
  (ON CRATE5 PALLET4) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DISTRIBUTOR3) (ON CRATE6 PALLET9) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR3) (ON CRATE7 CRATE6)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR5)
  (ON CRATE8 PALLET11) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DEPOT4) (ON CRATE9 CRATE5) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DEPOT2) (ON CRATE10 PALLET2)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DEPOT3)
  (ON CRATE11 CRATE2) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DISTRIBUTOR1) (ON CRATE12 CRATE0) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DEPOT5) (ON CRATE13 CRATE4)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR4)
  (ON CRATE14 CRATE1) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DEPOT2) (ON CRATE15 CRATE10) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR0) (ON CRATE16 CRATE3)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR1)
  (ON CRATE17 CRATE12) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DISTRIBUTOR2) (ON CRATE18 PALLET8) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR4) (ON CRATE19 CRATE14)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR3)
  (ON CRATE20 CRATE7) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DEPOT2) (ON CRATE21 CRATE15) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR5) (ON CRATE22 CRATE8)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DEPOT2)
  (ON CRATE23 CRATE21) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DISTRIBUTOR2) (ON CRATE24 CRATE18) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DEPOT3) (ON CRATE25 CRATE11)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR4)
  (ON CRATE26 CRATE19) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DEPOT0) (ON CRATE27 PALLET0) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DEPOT5) (ON CRATE28 CRATE13)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DEPOT3)
  (ON CRATE29 CRATE25) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DEPOT2) (ON CRATE30 CRATE23) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR3) (ON CRATE31 CRATE20)
  (CRATE CRATE32) (SURFACE CRATE32) (AT CRATE32 DISTRIBUTOR0)
  (ON CRATE32 CRATE16) (CRATE CRATE33) (SURFACE CRATE33)
  (AT CRATE33 DISTRIBUTOR2) (ON CRATE33 CRATE24) (CRATE CRATE34)
  (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR2) (ON CRATE34 CRATE33)
  (CRATE CRATE35) (SURFACE CRATE35) (AT CRATE35 DEPOT3)
  (ON CRATE35 CRATE29) (CRATE CRATE36) (SURFACE CRATE36)
  (AT CRATE36 DISTRIBUTOR5) (ON CRATE36 CRATE22) (CRATE CRATE37)
  (SURFACE CRATE37) (AT CRATE37 DEPOT0) (ON CRATE37 CRATE27)
  (CRATE CRATE38) (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR1)
  (ON CRATE38 CRATE17) (CRATE CRATE39) (SURFACE CRATE39)
  (AT CRATE39 DISTRIBUTOR4) (ON CRATE39 CRATE26) (CRATE CRATE40)
  (SURFACE CRATE40) (AT CRATE40 DISTRIBUTOR3) (ON CRATE40 CRATE31)
  (CRATE CRATE41) (SURFACE CRATE41) (AT CRATE41 DEPOT2)
  (ON CRATE41 CRATE30) (CRATE CRATE42) (SURFACE CRATE42)
  (AT CRATE42 DISTRIBUTOR2) (ON CRATE42 CRATE34) (CRATE CRATE43)
  (SURFACE CRATE43) (AT CRATE43 DEPOT1) (ON CRATE43 PALLET1)
  (CRATE CRATE44) (SURFACE CRATE44) (AT CRATE44 DISTRIBUTOR2)
  (ON CRATE44 CRATE42) (CRATE CRATE45) (SURFACE CRATE45)
  (AT CRATE45 DEPOT5) (ON CRATE45 CRATE28) (CRATE CRATE46)
  (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR5) (ON CRATE46 CRATE36)
  (CRATE CRATE47) (SURFACE CRATE47) (AT CRATE47 DISTRIBUTOR2)
  (ON CRATE47 CRATE44) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5)) 
 
 ;; goal 
((ON CRATE0 CRATE1) (ON CRATE1 CRATE24) (ON CRATE2 CRATE20)
 (ON CRATE3 PALLET10) (ON CRATE4 CRATE39) (ON CRATE5 CRATE3)
 (ON CRATE6 PALLET3) (ON CRATE7 CRATE38) (ON CRATE8 CRATE29)
 (ON CRATE9 PALLET1) (ON CRATE10 PALLET8) (ON CRATE11 CRATE10)
 (ON CRATE12 CRATE23) (ON CRATE13 CRATE34) (ON CRATE14 CRATE8)
 (ON CRATE15 CRATE35) (ON CRATE16 CRATE47) (ON CRATE18 PALLET2)
 (ON CRATE19 PALLET7) (ON CRATE20 CRATE14) (ON CRATE21 PALLET9)
 (ON CRATE23 CRATE15) (ON CRATE24 CRATE6) (ON CRATE25 PALLET0)
 (ON CRATE26 CRATE5) (ON CRATE27 CRATE0) (ON CRATE28 CRATE43)
 (ON CRATE29 CRATE21) (ON CRATE30 CRATE28) (ON CRATE33 CRATE46)
 (ON CRATE34 CRATE45) (ON CRATE35 PALLET5) (ON CRATE36 CRATE27)
 (ON CRATE38 CRATE19) (ON CRATE39 CRATE13) (ON CRATE42 PALLET11)
 (ON CRATE43 PALLET4) (ON CRATE44 CRATE26) (ON CRATE45 PALLET6)
 (ON CRATE46 CRATE25) (ON CRATE47 CRATE9)))