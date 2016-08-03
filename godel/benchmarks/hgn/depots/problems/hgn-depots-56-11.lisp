(in-package :shop2)
(defproblem DEPOTPROB110 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE41) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE26) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE53)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE15) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE49) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE35)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE55) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR0) (CLEAR CRATE28) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR1) (CLEAR CRATE45)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR2)
  (CLEAR CRATE52) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR3) (CLEAR CRATE43) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR4) (CLEAR PALLET11)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR5)
  (CLEAR CRATE54) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR6) (CLEAR CRATE50) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR5) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DEPOT3)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DEPOT4)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DEPOT5)
  (AVAILABLE HOIST5) (HOIST HOIST6) (AT HOIST6 DEPOT6)
  (AVAILABLE HOIST6) (HOIST HOIST7) (AT HOIST7 DISTRIBUTOR0)
  (AVAILABLE HOIST7) (HOIST HOIST8) (AT HOIST8 DISTRIBUTOR1)
  (AVAILABLE HOIST8) (HOIST HOIST9) (AT HOIST9 DISTRIBUTOR2)
  (AVAILABLE HOIST9) (HOIST HOIST10) (AT HOIST10 DISTRIBUTOR3)
  (AVAILABLE HOIST10) (HOIST HOIST11) (AT HOIST11 DISTRIBUTOR4)
  (AVAILABLE HOIST11) (HOIST HOIST12) (AT HOIST12 DISTRIBUTOR5)
  (AVAILABLE HOIST12) (HOIST HOIST13) (AT HOIST13 DISTRIBUTOR6)
  (AVAILABLE HOIST13) (CRATE CRATE0) (SURFACE CRATE0)
  (AT CRATE0 DEPOT2) (ON CRATE0 PALLET2) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT4) (ON CRATE1 PALLET4)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT1)
  (ON CRATE2 PALLET1) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT1) (ON CRATE3 CRATE2) (CRATE CRATE4) (SURFACE CRATE4)
  (AT CRATE4 DISTRIBUTOR1) (ON CRATE4 PALLET8) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DEPOT5) (ON CRATE5 PALLET5)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DEPOT6)
  (ON CRATE6 PALLET6) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DEPOT5) (ON CRATE7 CRATE5) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DEPOT1) (ON CRATE8 CRATE3) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DEPOT0) (ON CRATE9 PALLET0) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR6) (ON CRATE10 PALLET13)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DEPOT6)
  (ON CRATE11 CRATE6) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DISTRIBUTOR1) (ON CRATE12 CRATE4) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DEPOT3) (ON CRATE13 PALLET3)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR1)
  (ON CRATE14 CRATE12) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DEPOT3) (ON CRATE15 CRATE13) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DEPOT6) (ON CRATE16 CRATE11)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DEPOT6)
  (ON CRATE17 CRATE16) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DEPOT2) (ON CRATE18 CRATE0) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR3) (ON CRATE19 PALLET10)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR1)
  (ON CRATE20 CRATE14) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DISTRIBUTOR0) (ON CRATE21 PALLET7) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DEPOT6) (ON CRATE22 CRATE17)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DEPOT2)
  (ON CRATE23 CRATE18) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DEPOT1) (ON CRATE24 CRATE8) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR3) (ON CRATE25 CRATE19)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DEPOT1)
  (ON CRATE26 CRATE24) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DEPOT4) (ON CRATE27 CRATE1) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DISTRIBUTOR0) (ON CRATE28 CRATE21)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DISTRIBUTOR2)
  (ON CRATE29 PALLET9) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DISTRIBUTOR6) (ON CRATE30 CRATE10) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR6) (ON CRATE31 CRATE30)
  (CRATE CRATE32) (SURFACE CRATE32) (AT CRATE32 DEPOT6)
  (ON CRATE32 CRATE22) (CRATE CRATE33) (SURFACE CRATE33)
  (AT CRATE33 DISTRIBUTOR6) (ON CRATE33 CRATE31) (CRATE CRATE34)
  (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR6) (ON CRATE34 CRATE33)
  (CRATE CRATE35) (SURFACE CRATE35) (AT CRATE35 DEPOT5)
  (ON CRATE35 CRATE7) (CRATE CRATE36) (SURFACE CRATE36)
  (AT CRATE36 DISTRIBUTOR5) (ON CRATE36 PALLET12) (CRATE CRATE37)
  (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR1) (ON CRATE37 CRATE20)
  (CRATE CRATE38) (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR5)
  (ON CRATE38 CRATE36) (CRATE CRATE39) (SURFACE CRATE39)
  (AT CRATE39 DISTRIBUTOR6) (ON CRATE39 CRATE34) (CRATE CRATE40)
  (SURFACE CRATE40) (AT CRATE40 DEPOT0) (ON CRATE40 CRATE9)
  (CRATE CRATE41) (SURFACE CRATE41) (AT CRATE41 DEPOT0)
  (ON CRATE41 CRATE40) (CRATE CRATE42) (SURFACE CRATE42)
  (AT CRATE42 DISTRIBUTOR5) (ON CRATE42 CRATE38) (CRATE CRATE43)
  (SURFACE CRATE43) (AT CRATE43 DISTRIBUTOR3) (ON CRATE43 CRATE25)
  (CRATE CRATE44) (SURFACE CRATE44) (AT CRATE44 DISTRIBUTOR5)
  (ON CRATE44 CRATE42) (CRATE CRATE45) (SURFACE CRATE45)
  (AT CRATE45 DISTRIBUTOR1) (ON CRATE45 CRATE37) (CRATE CRATE46)
  (SURFACE CRATE46) (AT CRATE46 DEPOT4) (ON CRATE46 CRATE27)
  (CRATE CRATE47) (SURFACE CRATE47) (AT CRATE47 DEPOT4)
  (ON CRATE47 CRATE46) (CRATE CRATE48) (SURFACE CRATE48)
  (AT CRATE48 DISTRIBUTOR6) (ON CRATE48 CRATE39) (CRATE CRATE49)
  (SURFACE CRATE49) (AT CRATE49 DEPOT4) (ON CRATE49 CRATE47)
  (CRATE CRATE50) (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR6)
  (ON CRATE50 CRATE48) (CRATE CRATE51) (SURFACE CRATE51)
  (AT CRATE51 DEPOT6) (ON CRATE51 CRATE32) (CRATE CRATE52)
  (SURFACE CRATE52) (AT CRATE52 DISTRIBUTOR2) (ON CRATE52 CRATE29)
  (CRATE CRATE53) (SURFACE CRATE53) (AT CRATE53 DEPOT2)
  (ON CRATE53 CRATE23) (CRATE CRATE54) (SURFACE CRATE54)
  (AT CRATE54 DISTRIBUTOR5) (ON CRATE54 CRATE44) (CRATE CRATE55)
  (SURFACE CRATE55) (AT CRATE55 DEPOT6) (ON CRATE55 CRATE51)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3)
  (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)) 
 
 ;; goal 
((ON CRATE0 CRATE12) (ON CRATE1 CRATE35) (ON CRATE2 PALLET10)
 (ON CRATE3 CRATE10) (ON CRATE6 PALLET8) (ON CRATE7 PALLET5)
 (ON CRATE8 CRATE33) (ON CRATE9 CRATE41) (ON CRATE10 CRATE49)
 (ON CRATE11 CRATE46) (ON CRATE12 CRATE34) (ON CRATE13 CRATE45)
 (ON CRATE15 CRATE32) (ON CRATE16 CRATE40) (ON CRATE17 CRATE27)
 (ON CRATE18 CRATE24) (ON CRATE19 CRATE23) (ON CRATE21 CRATE43)
 (ON CRATE22 CRATE16) (ON CRATE23 CRATE2) (ON CRATE24 CRATE48)
 (ON CRATE25 PALLET13) (ON CRATE26 CRATE7) (ON CRATE27 CRATE9)
 (ON CRATE28 CRATE19) (ON CRATE29 PALLET0) (ON CRATE30 PALLET4)
 (ON CRATE31 CRATE54) (ON CRATE32 CRATE29) (ON CRATE33 PALLET7)
 (ON CRATE34 PALLET9) (ON CRATE35 CRATE6) (ON CRATE36 CRATE13)
 (ON CRATE38 CRATE1) (ON CRATE40 PALLET12) (ON CRATE41 PALLET3)
 (ON CRATE42 CRATE36) (ON CRATE43 CRATE26) (ON CRATE44 CRATE15)
 (ON CRATE45 PALLET2) (ON CRATE46 PALLET6) (ON CRATE48 CRATE52)
 (ON CRATE49 CRATE42) (ON CRATE50 CRATE25) (ON CRATE51 CRATE8)
 (ON CRATE52 PALLET11) (ON CRATE54 PALLET1) (ON CRATE55 CRATE44)))