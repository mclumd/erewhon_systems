(in-package :shop2)
(defproblem DEPOTPROB140 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE54) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE47) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE40)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE35) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE43) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE41)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR PALLET6) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR0) (CLEAR CRATE31) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR1) (CLEAR CRATE51)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR2)
  (CLEAR CRATE53) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR3) (CLEAR CRATE44) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR4) (CLEAR CRATE55)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR5)
  (CLEAR CRATE52) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR6) (CLEAR CRATE46) (TRUCK TRUCK0)
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
  (AT CRATE0 DISTRIBUTOR6) (ON CRATE0 PALLET13) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR5) (ON CRATE1 PALLET12)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR6)
  (ON CRATE2 CRATE0) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DISTRIBUTOR4) (ON CRATE3 PALLET11) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT2) (ON CRATE4 PALLET2)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR2)
  (ON CRATE5 PALLET9) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT2) (ON CRATE6 CRATE4) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DISTRIBUTOR5) (ON CRATE7 CRATE1) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DEPOT5) (ON CRATE8 PALLET5)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT3)
  (ON CRATE9 PALLET3) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT1) (ON CRATE10 PALLET1) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR6) (ON CRATE11 CRATE2)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR3)
  (ON CRATE12 PALLET10) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR5) (ON CRATE13 CRATE7) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR2) (ON CRATE14 CRATE5)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR0)
  (ON CRATE15 PALLET7) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DEPOT2) (ON CRATE16 CRATE6) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR2) (ON CRATE17 CRATE14)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR0)
  (ON CRATE18 CRATE15) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DISTRIBUTOR6) (ON CRATE19 CRATE11) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DEPOT5) (ON CRATE20 CRATE8)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR4)
  (ON CRATE21 CRATE3) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR3) (ON CRATE22 CRATE12) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DEPOT2) (ON CRATE23 CRATE16)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DEPOT3)
  (ON CRATE24 CRATE9) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DEPOT0) (ON CRATE25 PALLET0) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR2) (ON CRATE26 CRATE17)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DEPOT3)
  (ON CRATE27 CRATE24) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DEPOT3) (ON CRATE28 CRATE27) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DEPOT0) (ON CRATE29 CRATE25)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DEPOT1)
  (ON CRATE30 CRATE10) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DISTRIBUTOR0) (ON CRATE31 CRATE18) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DEPOT0) (ON CRATE32 CRATE29)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DEPOT5)
  (ON CRATE33 CRATE20) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DISTRIBUTOR2) (ON CRATE34 CRATE26) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DEPOT3) (ON CRATE35 CRATE28)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DEPOT0)
  (ON CRATE36 CRATE32) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR2) (ON CRATE37 CRATE34) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR4) (ON CRATE38 CRATE21)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR5)
  (ON CRATE39 CRATE13) (CRATE CRATE40) (SURFACE CRATE40)
  (AT CRATE40 DEPOT2) (ON CRATE40 CRATE23) (CRATE CRATE41)
  (SURFACE CRATE41) (AT CRATE41 DEPOT5) (ON CRATE41 CRATE33)
  (CRATE CRATE42) (SURFACE CRATE42) (AT CRATE42 DISTRIBUTOR6)
  (ON CRATE42 CRATE19) (CRATE CRATE43) (SURFACE CRATE43)
  (AT CRATE43 DEPOT4) (ON CRATE43 PALLET4) (CRATE CRATE44)
  (SURFACE CRATE44) (AT CRATE44 DISTRIBUTOR3) (ON CRATE44 CRATE22)
  (CRATE CRATE45) (SURFACE CRATE45) (AT CRATE45 DEPOT1)
  (ON CRATE45 CRATE30) (CRATE CRATE46) (SURFACE CRATE46)
  (AT CRATE46 DISTRIBUTOR6) (ON CRATE46 CRATE42) (CRATE CRATE47)
  (SURFACE CRATE47) (AT CRATE47 DEPOT1) (ON CRATE47 CRATE45)
  (CRATE CRATE48) (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR4)
  (ON CRATE48 CRATE38) (CRATE CRATE49) (SURFACE CRATE49)
  (AT CRATE49 DISTRIBUTOR1) (ON CRATE49 PALLET8) (CRATE CRATE50)
  (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR5) (ON CRATE50 CRATE39)
  (CRATE CRATE51) (SURFACE CRATE51) (AT CRATE51 DISTRIBUTOR1)
  (ON CRATE51 CRATE49) (CRATE CRATE52) (SURFACE CRATE52)
  (AT CRATE52 DISTRIBUTOR5) (ON CRATE52 CRATE50) (CRATE CRATE53)
  (SURFACE CRATE53) (AT CRATE53 DISTRIBUTOR2) (ON CRATE53 CRATE37)
  (CRATE CRATE54) (SURFACE CRATE54) (AT CRATE54 DEPOT0)
  (ON CRATE54 CRATE36) (CRATE CRATE55) (SURFACE CRATE55)
  (AT CRATE55 DISTRIBUTOR4) (ON CRATE55 CRATE48) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)) 
 
 ;; goal 
((ON CRATE1 CRATE32) (ON CRATE2 CRATE8) (ON CRATE3 CRATE12)
 (ON CRATE4 CRATE22) (ON CRATE5 CRATE13) (ON CRATE6 PALLET8)
 (ON CRATE7 CRATE54) (ON CRATE8 CRATE49) (ON CRATE9 CRATE55)
 (ON CRATE10 CRATE6) (ON CRATE11 PALLET1) (ON CRATE12 PALLET2)
 (ON CRATE13 PALLET7) (ON CRATE14 CRATE38) (ON CRATE15 CRATE16)
 (ON CRATE16 PALLET3) (ON CRATE17 CRATE40) (ON CRATE18 PALLET10)
 (ON CRATE19 PALLET13) (ON CRATE20 CRATE4) (ON CRATE21 CRATE31)
 (ON CRATE22 PALLET12) (ON CRATE23 CRATE3) (ON CRATE24 PALLET9)
 (ON CRATE25 CRATE34) (ON CRATE26 PALLET11) (ON CRATE28 CRATE41)
 (ON CRATE29 CRATE52) (ON CRATE30 CRATE11) (ON CRATE31 CRATE18)
 (ON CRATE32 CRATE2) (ON CRATE33 CRATE17) (ON CRATE34 CRATE26)
 (ON CRATE36 CRATE29) (ON CRATE37 CRATE14) (ON CRATE38 CRATE30)
 (ON CRATE40 CRATE25) (ON CRATE41 PALLET5) (ON CRATE42 PALLET6)
 (ON CRATE43 CRATE33) (ON CRATE44 CRATE46) (ON CRATE45 PALLET4)
 (ON CRATE46 PALLET0) (ON CRATE47 CRATE24) (ON CRATE48 CRATE28)
 (ON CRATE49 CRATE47) (ON CRATE51 CRATE10) (ON CRATE52 CRATE51)
 (ON CRATE53 CRATE23) (ON CRATE54 CRATE15) (ON CRATE55 CRATE19)))