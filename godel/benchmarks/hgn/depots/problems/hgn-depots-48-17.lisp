(in-package :shop2)
(defproblem DEPOTPROB170 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE29) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE42) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE44)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE46) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE47) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE40)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DISTRIBUTOR0)
  (CLEAR CRATE16) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR1) (CLEAR CRATE12) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR2) (CLEAR CRATE43)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR3)
  (CLEAR CRATE25) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR4) (CLEAR CRATE33) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR5) (CLEAR CRATE39)
  (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR2) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DEPOT2) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DEPOT3) (AVAILABLE HOIST3) (HOIST HOIST4)
  (AT HOIST4 DEPOT4) (AVAILABLE HOIST4) (HOIST HOIST5)
  (AT HOIST5 DEPOT5) (AVAILABLE HOIST5) (HOIST HOIST6)
  (AT HOIST6 DISTRIBUTOR0) (AVAILABLE HOIST6) (HOIST HOIST7)
  (AT HOIST7 DISTRIBUTOR1) (AVAILABLE HOIST7) (HOIST HOIST8)
  (AT HOIST8 DISTRIBUTOR2) (AVAILABLE HOIST8) (HOIST HOIST9)
  (AT HOIST9 DISTRIBUTOR3) (AVAILABLE HOIST9) (HOIST HOIST10)
  (AT HOIST10 DISTRIBUTOR4) (AVAILABLE HOIST10) (HOIST HOIST11)
  (AT HOIST11 DISTRIBUTOR5) (AVAILABLE HOIST11) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DISTRIBUTOR1) (ON CRATE0 PALLET7)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DEPOT0)
  (ON CRATE1 PALLET0) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DEPOT5) (ON CRATE2 PALLET5) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR2) (ON CRATE3 PALLET8)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DEPOT2)
  (ON CRATE4 PALLET2) (CRATE CRATE5) (SURFACE CRATE5)
  (AT CRATE5 DEPOT0) (ON CRATE5 CRATE1) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT3) (ON CRATE6 PALLET3) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DEPOT4) (ON CRATE7 PALLET4)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DEPOT5) (ON CRATE8 CRATE2)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT2) (ON CRATE9 CRATE4)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR3)
  (ON CRATE10 PALLET9) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DISTRIBUTOR1) (ON CRATE11 CRATE0) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR1) (ON CRATE12 CRATE11)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT2)
  (ON CRATE13 CRATE9) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR2) (ON CRATE14 CRATE3) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DEPOT5) (ON CRATE15 CRATE8)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR0)
  (ON CRATE16 PALLET6) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DEPOT5) (ON CRATE17 CRATE15) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR4) (ON CRATE18 PALLET10)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT1)
  (ON CRATE19 PALLET1) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT3) (ON CRATE20 CRATE6) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DEPOT0) (ON CRATE21 CRATE5)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DEPOT2)
  (ON CRATE22 CRATE13) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DISTRIBUTOR2) (ON CRATE23 CRATE14) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR5) (ON CRATE24 PALLET11)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR3)
  (ON CRATE25 CRATE10) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DEPOT3) (ON CRATE26 CRATE20) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DEPOT4) (ON CRATE27 CRATE7)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DEPOT3)
  (ON CRATE28 CRATE26) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DEPOT0) (ON CRATE29 CRATE21) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DEPOT3) (ON CRATE30 CRATE28)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DEPOT4)
  (ON CRATE31 CRATE27) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DISTRIBUTOR5) (ON CRATE32 CRATE24) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR4) (ON CRATE33 CRATE18)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR5)
  (ON CRATE34 CRATE32) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DISTRIBUTOR5) (ON CRATE35 CRATE34) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DEPOT2) (ON CRATE36 CRATE22)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR5)
  (ON CRATE37 CRATE35) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DEPOT4) (ON CRATE38 CRATE31) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR5) (ON CRATE39 CRATE37)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DEPOT5)
  (ON CRATE40 CRATE17) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT2) (ON CRATE41 CRATE36) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DEPOT1) (ON CRATE42 CRATE19)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DISTRIBUTOR2)
  (ON CRATE43 CRATE23) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DEPOT2) (ON CRATE44 CRATE41) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DEPOT4) (ON CRATE45 CRATE38)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DEPOT3)
  (ON CRATE46 CRATE30) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DEPOT4) (ON CRATE47 CRATE45) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)
  (PLACE DISTRIBUTOR5)) 
 
 ;; goal 
((ON CRATE0 CRATE20) (ON CRATE2 CRATE10) (ON CRATE3 CRATE32)
 (ON CRATE4 CRATE36) (ON CRATE6 CRATE9) (ON CRATE7 PALLET8)
 (ON CRATE8 CRATE0) (ON CRATE9 PALLET6) (ON CRATE10 CRATE31)
 (ON CRATE11 PALLET0) (ON CRATE12 CRATE38) (ON CRATE13 CRATE6)
 (ON CRATE14 CRATE47) (ON CRATE15 CRATE11) (ON CRATE16 PALLET5)
 (ON CRATE17 CRATE3) (ON CRATE18 CRATE7) (ON CRATE19 CRATE37)
 (ON CRATE20 PALLET3) (ON CRATE21 PALLET11) (ON CRATE22 CRATE35)
 (ON CRATE23 CRATE14) (ON CRATE25 CRATE21) (ON CRATE26 PALLET2)
 (ON CRATE28 CRATE12) (ON CRATE29 CRATE17) (ON CRATE30 CRATE41)
 (ON CRATE31 PALLET7) (ON CRATE32 CRATE2) (ON CRATE33 CRATE45)
 (ON CRATE34 CRATE46) (ON CRATE35 CRATE15) (ON CRATE36 CRATE39)
 (ON CRATE37 CRATE34) (ON CRATE38 PALLET9) (ON CRATE39 CRATE16)
 (ON CRATE40 CRATE26) (ON CRATE41 CRATE23) (ON CRATE43 PALLET1)
 (ON CRATE45 CRATE18) (ON CRATE46 PALLET10) (ON CRATE47 PALLET4)))