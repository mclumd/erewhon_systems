(in-package :shop2)
(defproblem DEPOTPROB170 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE39) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE31) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE33)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE41) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE45) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE53)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE43) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DISTRIBUTOR0) (CLEAR CRATE37) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR1) (CLEAR CRATE38)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR2)
  (CLEAR CRATE55) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR3) (CLEAR CRATE54) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR4) (CLEAR CRATE51)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR5)
  (CLEAR CRATE35) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR6) (CLEAR CRATE23) (TRUCK TRUCK0)
  (AT TRUCK0 DEPOT4) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DEPOT0) (ON CRATE0 PALLET0) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT4) (ON CRATE1 PALLET4)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT4) (ON CRATE2 CRATE1)
  (CRATE CRATE3) (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR6)
  (ON CRATE3 PALLET13) (CRATE CRATE4) (SURFACE CRATE4)
  (AT CRATE4 DISTRIBUTOR4) (ON CRATE4 PALLET11) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR6) (ON CRATE5 CRATE3)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DISTRIBUTOR6)
  (ON CRATE6 CRATE5) (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DEPOT2)
  (ON CRATE7 PALLET2) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DISTRIBUTOR6) (ON CRATE8 CRATE6) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DEPOT5) (ON CRATE9 PALLET5)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR6)
  (ON CRATE10 CRATE8) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT6) (ON CRATE11 PALLET6) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DEPOT2) (ON CRATE12 CRATE7)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT1)
  (ON CRATE13 PALLET1) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR2) (ON CRATE14 PALLET9) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DEPOT2) (ON CRATE15 CRATE12)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DEPOT5)
  (ON CRATE16 CRATE9) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DEPOT3) (ON CRATE17 PALLET3) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DEPOT5) (ON CRATE18 CRATE16)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR1)
  (ON CRATE19 PALLET8) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT0) (ON CRATE20 CRATE0) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DEPOT3) (ON CRATE21 CRATE17)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR5)
  (ON CRATE22 PALLET12) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DISTRIBUTOR6) (ON CRATE23 CRATE10) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR4) (ON CRATE24 CRATE4)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DEPOT5)
  (ON CRATE25 CRATE18) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DISTRIBUTOR3) (ON CRATE26 PALLET10) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR0) (ON CRATE27 PALLET7)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DISTRIBUTOR2)
  (ON CRATE28 CRATE14) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DISTRIBUTOR0) (ON CRATE29 CRATE27) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DEPOT0) (ON CRATE30 CRATE20)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DEPOT1)
  (ON CRATE31 CRATE13) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DEPOT3) (ON CRATE32 CRATE21) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DEPOT2) (ON CRATE33 CRATE15)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR0)
  (ON CRATE34 CRATE29) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DISTRIBUTOR5) (ON CRATE35 CRATE22) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DEPOT4) (ON CRATE36 CRATE2)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR0)
  (ON CRATE37 CRATE34) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DISTRIBUTOR1) (ON CRATE38 CRATE19) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DEPOT0) (ON CRATE39 CRATE30)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DISTRIBUTOR4)
  (ON CRATE40 CRATE24) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT3) (ON CRATE41 CRATE32) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DEPOT4) (ON CRATE42 CRATE36)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DEPOT6)
  (ON CRATE43 CRATE11) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DEPOT5) (ON CRATE44 CRATE25) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DEPOT4) (ON CRATE45 CRATE42)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR3)
  (ON CRATE46 CRATE26) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DISTRIBUTOR4) (ON CRATE47 CRATE40) (CRATE CRATE48)
  (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR3) (ON CRATE48 CRATE46)
  (CRATE CRATE49) (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR2)
  (ON CRATE49 CRATE28) (CRATE CRATE50) (SURFACE CRATE50)
  (AT CRATE50 DISTRIBUTOR4) (ON CRATE50 CRATE47) (CRATE CRATE51)
  (SURFACE CRATE51) (AT CRATE51 DISTRIBUTOR4) (ON CRATE51 CRATE50)
  (CRATE CRATE52) (SURFACE CRATE52) (AT CRATE52 DISTRIBUTOR2)
  (ON CRATE52 CRATE49) (CRATE CRATE53) (SURFACE CRATE53)
  (AT CRATE53 DEPOT5) (ON CRATE53 CRATE44) (CRATE CRATE54)
  (SURFACE CRATE54) (AT CRATE54 DISTRIBUTOR3) (ON CRATE54 CRATE48)
  (CRATE CRATE55) (SURFACE CRATE55) (AT CRATE55 DISTRIBUTOR2)
  (ON CRATE55 CRATE52) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)
  (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5)
  (PLACE DISTRIBUTOR6)) 
 
 ;; goal 
((ON CRATE0 CRATE19) (ON CRATE1 CRATE44) (ON CRATE2 CRATE11)
 (ON CRATE3 PALLET8) (ON CRATE4 PALLET3) (ON CRATE5 PALLET10)
 (ON CRATE6 CRATE43) (ON CRATE7 PALLET0) (ON CRATE8 PALLET9)
 (ON CRATE9 PALLET4) (ON CRATE10 CRATE30) (ON CRATE11 PALLET7)
 (ON CRATE12 PALLET13) (ON CRATE13 CRATE0) (ON CRATE14 CRATE22)
 (ON CRATE15 CRATE52) (ON CRATE16 CRATE2) (ON CRATE18 CRATE10)
 (ON CRATE19 CRATE33) (ON CRATE20 CRATE7) (ON CRATE22 CRATE12)
 (ON CRATE23 CRATE16) (ON CRATE24 PALLET12) (ON CRATE25 PALLET6)
 (ON CRATE26 CRATE3) (ON CRATE28 CRATE29) (ON CRATE29 CRATE46)
 (ON CRATE30 CRATE4) (ON CRATE31 CRATE36) (ON CRATE32 PALLET5)
 (ON CRATE33 PALLET11) (ON CRATE34 CRATE50) (ON CRATE35 CRATE32)
 (ON CRATE36 CRATE35) (ON CRATE37 CRATE23) (ON CRATE38 CRATE9)
 (ON CRATE39 CRATE31) (ON CRATE40 CRATE34) (ON CRATE41 CRATE25)
 (ON CRATE42 CRATE41) (ON CRATE43 CRATE55) (ON CRATE44 CRATE24)
 (ON CRATE46 CRATE8) (ON CRATE47 CRATE5) (ON CRATE48 CRATE28)
 (ON CRATE49 CRATE18) (ON CRATE50 PALLET1) (ON CRATE52 CRATE40)
 (ON CRATE55 CRATE42)))