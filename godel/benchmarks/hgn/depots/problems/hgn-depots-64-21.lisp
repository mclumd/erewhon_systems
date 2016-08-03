(in-package :shop2)
(defproblem DEPOTPROB210 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE62) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE53) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE43)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE57) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE38) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE36)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6) (CLEAR CRATE9)
  (PALLET PALLET7) (SURFACE PALLET7) (AT PALLET7 DEPOT7)
  (CLEAR CRATE48) (PALLET PALLET8) (SURFACE PALLET8)
  (AT PALLET8 DISTRIBUTOR0) (CLEAR CRATE63) (PALLET PALLET9)
  (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR1) (CLEAR CRATE41)
  (PALLET PALLET10) (SURFACE PALLET10) (AT PALLET10 DISTRIBUTOR2)
  (CLEAR CRATE31) (PALLET PALLET11) (SURFACE PALLET11)
  (AT PALLET11 DISTRIBUTOR3) (CLEAR CRATE51) (PALLET PALLET12)
  (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR4) (CLEAR CRATE54)
  (PALLET PALLET13) (SURFACE PALLET13) (AT PALLET13 DISTRIBUTOR5)
  (CLEAR CRATE58) (PALLET PALLET14) (SURFACE PALLET14)
  (AT PALLET14 DISTRIBUTOR6) (CLEAR CRATE55) (PALLET PALLET15)
  (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR7) (CLEAR CRATE60)
  (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR7) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DEPOT2) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DEPOT3) (AVAILABLE HOIST3) (HOIST HOIST4)
  (AT HOIST4 DEPOT4) (AVAILABLE HOIST4) (HOIST HOIST5)
  (AT HOIST5 DEPOT5) (AVAILABLE HOIST5) (HOIST HOIST6)
  (AT HOIST6 DEPOT6) (AVAILABLE HOIST6) (HOIST HOIST7)
  (AT HOIST7 DEPOT7) (AVAILABLE HOIST7) (HOIST HOIST8)
  (AT HOIST8 DISTRIBUTOR0) (AVAILABLE HOIST8) (HOIST HOIST9)
  (AT HOIST9 DISTRIBUTOR1) (AVAILABLE HOIST9) (HOIST HOIST10)
  (AT HOIST10 DISTRIBUTOR2) (AVAILABLE HOIST10) (HOIST HOIST11)
  (AT HOIST11 DISTRIBUTOR3) (AVAILABLE HOIST11) (HOIST HOIST12)
  (AT HOIST12 DISTRIBUTOR4) (AVAILABLE HOIST12) (HOIST HOIST13)
  (AT HOIST13 DISTRIBUTOR5) (AVAILABLE HOIST13) (HOIST HOIST14)
  (AT HOIST14 DISTRIBUTOR6) (AVAILABLE HOIST14) (HOIST HOIST15)
  (AT HOIST15 DISTRIBUTOR7) (AVAILABLE HOIST15) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DEPOT0) (ON CRATE0 PALLET0)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DEPOT7)
  (ON CRATE1 PALLET7) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DISTRIBUTOR5) (ON CRATE2 PALLET13) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DEPOT7) (ON CRATE3 CRATE1) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR1) (ON CRATE4 PALLET9)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR5)
  (ON CRATE5 CRATE2) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DISTRIBUTOR5) (ON CRATE6 CRATE5) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DISTRIBUTOR1) (ON CRATE7 CRATE4)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DEPOT7) (ON CRATE8 CRATE3)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT6)
  (ON CRATE9 PALLET6) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DISTRIBUTOR4) (ON CRATE10 PALLET12) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR0) (ON CRATE11 PALLET8)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR2)
  (ON CRATE12 PALLET10) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR7) (ON CRATE13 PALLET15) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR5) (ON CRATE14 CRATE6)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DEPOT1)
  (ON CRATE15 PALLET1) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DISTRIBUTOR2) (ON CRATE16 CRATE12) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DEPOT3) (ON CRATE17 PALLET3)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DEPOT2)
  (ON CRATE18 PALLET2) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DISTRIBUTOR5) (ON CRATE19 CRATE14) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DEPOT1) (ON CRATE20 CRATE15)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DEPOT5)
  (ON CRATE21 PALLET5) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR5) (ON CRATE22 CRATE19) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR6) (ON CRATE23 PALLET14)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DEPOT4)
  (ON CRATE24 PALLET4) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DEPOT1) (ON CRATE25 CRATE20) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR5) (ON CRATE26 CRATE22)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR3)
  (ON CRATE27 PALLET11) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DISTRIBUTOR7) (ON CRATE28 CRATE13) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DEPOT7) (ON CRATE29 CRATE8)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR3)
  (ON CRATE30 CRATE27) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DISTRIBUTOR2) (ON CRATE31 CRATE16) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DEPOT2) (ON CRATE32 CRATE18)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR5)
  (ON CRATE33 CRATE26) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DISTRIBUTOR0) (ON CRATE34 CRATE11) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DEPOT0) (ON CRATE35 CRATE0)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DEPOT5)
  (ON CRATE36 CRATE21) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR1) (ON CRATE37 CRATE7) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DEPOT4) (ON CRATE38 CRATE24)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR0)
  (ON CRATE39 CRATE34) (CRATE CRATE40) (SURFACE CRATE40)
  (AT CRATE40 DISTRIBUTOR4) (ON CRATE40 CRATE10) (CRATE CRATE41)
  (SURFACE CRATE41) (AT CRATE41 DISTRIBUTOR1) (ON CRATE41 CRATE37)
  (CRATE CRATE42) (SURFACE CRATE42) (AT CRATE42 DEPOT2)
  (ON CRATE42 CRATE32) (CRATE CRATE43) (SURFACE CRATE43)
  (AT CRATE43 DEPOT2) (ON CRATE43 CRATE42) (CRATE CRATE44)
  (SURFACE CRATE44) (AT CRATE44 DISTRIBUTOR7) (ON CRATE44 CRATE28)
  (CRATE CRATE45) (SURFACE CRATE45) (AT CRATE45 DISTRIBUTOR6)
  (ON CRATE45 CRATE23) (CRATE CRATE46) (SURFACE CRATE46)
  (AT CRATE46 DEPOT3) (ON CRATE46 CRATE17) (CRATE CRATE47)
  (SURFACE CRATE47) (AT CRATE47 DEPOT0) (ON CRATE47 CRATE35)
  (CRATE CRATE48) (SURFACE CRATE48) (AT CRATE48 DEPOT7)
  (ON CRATE48 CRATE29) (CRATE CRATE49) (SURFACE CRATE49)
  (AT CRATE49 DISTRIBUTOR3) (ON CRATE49 CRATE30) (CRATE CRATE50)
  (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR0) (ON CRATE50 CRATE39)
  (CRATE CRATE51) (SURFACE CRATE51) (AT CRATE51 DISTRIBUTOR3)
  (ON CRATE51 CRATE49) (CRATE CRATE52) (SURFACE CRATE52)
  (AT CRATE52 DEPOT1) (ON CRATE52 CRATE25) (CRATE CRATE53)
  (SURFACE CRATE53) (AT CRATE53 DEPOT1) (ON CRATE53 CRATE52)
  (CRATE CRATE54) (SURFACE CRATE54) (AT CRATE54 DISTRIBUTOR4)
  (ON CRATE54 CRATE40) (CRATE CRATE55) (SURFACE CRATE55)
  (AT CRATE55 DISTRIBUTOR6) (ON CRATE55 CRATE45) (CRATE CRATE56)
  (SURFACE CRATE56) (AT CRATE56 DEPOT3) (ON CRATE56 CRATE46)
  (CRATE CRATE57) (SURFACE CRATE57) (AT CRATE57 DEPOT3)
  (ON CRATE57 CRATE56) (CRATE CRATE58) (SURFACE CRATE58)
  (AT CRATE58 DISTRIBUTOR5) (ON CRATE58 CRATE33) (CRATE CRATE59)
  (SURFACE CRATE59) (AT CRATE59 DISTRIBUTOR0) (ON CRATE59 CRATE50)
  (CRATE CRATE60) (SURFACE CRATE60) (AT CRATE60 DISTRIBUTOR7)
  (ON CRATE60 CRATE44) (CRATE CRATE61) (SURFACE CRATE61)
  (AT CRATE61 DISTRIBUTOR0) (ON CRATE61 CRATE59) (CRATE CRATE62)
  (SURFACE CRATE62) (AT CRATE62 DEPOT0) (ON CRATE62 CRATE47)
  (CRATE CRATE63) (SURFACE CRATE63) (AT CRATE63 DISTRIBUTOR0)
  (ON CRATE63 CRATE61) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6)
  (PLACE DEPOT7) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)
  (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7)) 
 
 ;; goal 
((ON CRATE1 CRATE20) (ON CRATE2 CRATE35) (ON CRATE3 CRATE52)
 (ON CRATE4 CRATE37) (ON CRATE5 CRATE51) (ON CRATE6 CRATE11)
 (ON CRATE7 PALLET1) (ON CRATE8 CRATE17) (ON CRATE9 CRATE44)
 (ON CRATE10 CRATE55) (ON CRATE11 CRATE49) (ON CRATE12 CRATE27)
 (ON CRATE13 CRATE31) (ON CRATE14 CRATE59) (ON CRATE16 PALLET12)
 (ON CRATE17 PALLET8) (ON CRATE18 CRATE9) (ON CRATE19 CRATE7)
 (ON CRATE20 CRATE40) (ON CRATE21 CRATE61) (ON CRATE22 PALLET7)
 (ON CRATE23 CRATE33) (ON CRATE24 CRATE57) (ON CRATE25 CRATE3)
 (ON CRATE27 PALLET14) (ON CRATE28 CRATE19) (ON CRATE29 CRATE12)
 (ON CRATE30 CRATE23) (ON CRATE31 PALLET3) (ON CRATE32 CRATE60)
 (ON CRATE33 PALLET5) (ON CRATE35 CRATE54) (ON CRATE37 PALLET10)
 (ON CRATE38 CRATE28) (ON CRATE39 CRATE4) (ON CRATE40 CRATE24)
 (ON CRATE42 CRATE14) (ON CRATE44 PALLET15) (ON CRATE45 CRATE10)
 (ON CRATE46 CRATE45) (ON CRATE48 CRATE22) (ON CRATE49 CRATE50)
 (ON CRATE50 CRATE25) (ON CRATE51 PALLET13) (ON CRATE52 PALLET6)
 (ON CRATE53 PALLET4) (ON CRATE54 PALLET11) (ON CRATE55 CRATE8)
 (ON CRATE56 CRATE18) (ON CRATE57 PALLET0) (ON CRATE59 CRATE32)
 (ON CRATE60 PALLET2) (ON CRATE61 PALLET9)))