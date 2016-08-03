(in-package :shop2)
(defproblem DEPOTPROB90 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE37) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE45) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE51)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE60) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE62) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE61)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE55) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE47) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DISTRIBUTOR0) (CLEAR CRATE46)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR1)
  (CLEAR CRATE63) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR2) (CLEAR CRATE50) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR3) (CLEAR CRATE53)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR4)
  (CLEAR CRATE41) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR5) (CLEAR CRATE52) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR6) (CLEAR CRATE57)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR7)
  (CLEAR CRATE56) (TRUCK TRUCK0) (AT TRUCK0 DEPOT5) (HOIST HOIST0)
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
  (AT CRATE2 DEPOT5) (ON CRATE2 PALLET5) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR6) (ON CRATE3 PALLET14)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR2)
  (ON CRATE4 PALLET10) (CRATE CRATE5) (SURFACE CRATE5)
  (AT CRATE5 DISTRIBUTOR7) (ON CRATE5 PALLET15) (CRATE CRATE6)
  (SURFACE CRATE6) (AT CRATE6 DEPOT2) (ON CRATE6 PALLET2)
  (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DEPOT3)
  (ON CRATE7 PALLET3) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DEPOT2) (ON CRATE8 CRATE6) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DISTRIBUTOR3) (ON CRATE9 PALLET11) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR2) (ON CRATE10 CRATE4)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR0)
  (ON CRATE11 PALLET8) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DEPOT1) (ON CRATE12 PALLET1) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DISTRIBUTOR3) (ON CRATE13 CRATE9)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR7)
  (ON CRATE14 CRATE5) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DEPOT7) (ON CRATE15 CRATE1) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR7) (ON CRATE16 CRATE14)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DEPOT4)
  (ON CRATE17 PALLET4) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DISTRIBUTOR3) (ON CRATE18 CRATE13) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DEPOT4) (ON CRATE19 CRATE17)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DEPOT4)
  (ON CRATE20 CRATE19) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DEPOT3) (ON CRATE21 CRATE7) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DEPOT0) (ON CRATE22 CRATE0)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR4)
  (ON CRATE23 PALLET12) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DISTRIBUTOR0) (ON CRATE24 CRATE11) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR7) (ON CRATE25 CRATE16)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DEPOT6)
  (ON CRATE26 PALLET6) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DEPOT6) (ON CRATE27 CRATE26) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DISTRIBUTOR7) (ON CRATE28 CRATE25)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DISTRIBUTOR7)
  (ON CRATE29 CRATE28) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DISTRIBUTOR2) (ON CRATE30 CRATE10) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR6) (ON CRATE31 CRATE3)
  (CRATE CRATE32) (SURFACE CRATE32) (AT CRATE32 DEPOT5)
  (ON CRATE32 CRATE2) (CRATE CRATE33) (SURFACE CRATE33)
  (AT CRATE33 DISTRIBUTOR6) (ON CRATE33 CRATE31) (CRATE CRATE34)
  (SURFACE CRATE34) (AT CRATE34 DEPOT5) (ON CRATE34 CRATE32)
  (CRATE CRATE35) (SURFACE CRATE35) (AT CRATE35 DEPOT6)
  (ON CRATE35 CRATE27) (CRATE CRATE36) (SURFACE CRATE36)
  (AT CRATE36 DISTRIBUTOR0) (ON CRATE36 CRATE24) (CRATE CRATE37)
  (SURFACE CRATE37) (AT CRATE37 DEPOT0) (ON CRATE37 CRATE22)
  (CRATE CRATE38) (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR7)
  (ON CRATE38 CRATE29) (CRATE CRATE39) (SURFACE CRATE39)
  (AT CRATE39 DISTRIBUTOR2) (ON CRATE39 CRATE30) (CRATE CRATE40)
  (SURFACE CRATE40) (AT CRATE40 DEPOT4) (ON CRATE40 CRATE20)
  (CRATE CRATE41) (SURFACE CRATE41) (AT CRATE41 DISTRIBUTOR4)
  (ON CRATE41 CRATE23) (CRATE CRATE42) (SURFACE CRATE42)
  (AT CRATE42 DEPOT1) (ON CRATE42 CRATE12) (CRATE CRATE43)
  (SURFACE CRATE43) (AT CRATE43 DEPOT2) (ON CRATE43 CRATE8)
  (CRATE CRATE44) (SURFACE CRATE44) (AT CRATE44 DEPOT3)
  (ON CRATE44 CRATE21) (CRATE CRATE45) (SURFACE CRATE45)
  (AT CRATE45 DEPOT1) (ON CRATE45 CRATE42) (CRATE CRATE46)
  (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR0) (ON CRATE46 CRATE36)
  (CRATE CRATE47) (SURFACE CRATE47) (AT CRATE47 DEPOT7)
  (ON CRATE47 CRATE15) (CRATE CRATE48) (SURFACE CRATE48)
  (AT CRATE48 DEPOT2) (ON CRATE48 CRATE43) (CRATE CRATE49)
  (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR6) (ON CRATE49 CRATE33)
  (CRATE CRATE50) (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR2)
  (ON CRATE50 CRATE39) (CRATE CRATE51) (SURFACE CRATE51)
  (AT CRATE51 DEPOT2) (ON CRATE51 CRATE48) (CRATE CRATE52)
  (SURFACE CRATE52) (AT CRATE52 DISTRIBUTOR5) (ON CRATE52 PALLET13)
  (CRATE CRATE53) (SURFACE CRATE53) (AT CRATE53 DISTRIBUTOR3)
  (ON CRATE53 CRATE18) (CRATE CRATE54) (SURFACE CRATE54)
  (AT CRATE54 DISTRIBUTOR7) (ON CRATE54 CRATE38) (CRATE CRATE55)
  (SURFACE CRATE55) (AT CRATE55 DEPOT6) (ON CRATE55 CRATE35)
  (CRATE CRATE56) (SURFACE CRATE56) (AT CRATE56 DISTRIBUTOR7)
  (ON CRATE56 CRATE54) (CRATE CRATE57) (SURFACE CRATE57)
  (AT CRATE57 DISTRIBUTOR6) (ON CRATE57 CRATE49) (CRATE CRATE58)
  (SURFACE CRATE58) (AT CRATE58 DEPOT4) (ON CRATE58 CRATE40)
  (CRATE CRATE59) (SURFACE CRATE59) (AT CRATE59 DEPOT3)
  (ON CRATE59 CRATE44) (CRATE CRATE60) (SURFACE CRATE60)
  (AT CRATE60 DEPOT3) (ON CRATE60 CRATE59) (CRATE CRATE61)
  (SURFACE CRATE61) (AT CRATE61 DEPOT5) (ON CRATE61 CRATE34)
  (CRATE CRATE62) (SURFACE CRATE62) (AT CRATE62 DEPOT4)
  (ON CRATE62 CRATE58) (CRATE CRATE63) (SURFACE CRATE63)
  (AT CRATE63 DISTRIBUTOR1) (ON CRATE63 PALLET9) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)
  (PLACE DISTRIBUTOR7)) 
 
 ;; goal 
((ON CRATE0 CRATE2) (ON CRATE1 CRATE21) (ON CRATE2 CRATE50)
 (ON CRATE3 PALLET3) (ON CRATE4 PALLET10) (ON CRATE5 CRATE41)
 (ON CRATE6 CRATE14) (ON CRATE7 PALLET1) (ON CRATE8 CRATE0)
 (ON CRATE9 CRATE22) (ON CRATE11 CRATE3) (ON CRATE13 PALLET2)
 (ON CRATE14 PALLET7) (ON CRATE15 PALLET8) (ON CRATE16 CRATE8)
 (ON CRATE17 CRATE39) (ON CRATE19 CRATE53) (ON CRATE20 CRATE61)
 (ON CRATE21 CRATE29) (ON CRATE22 CRATE13) (ON CRATE23 PALLET13)
 (ON CRATE24 CRATE62) (ON CRATE25 PALLET9) (ON CRATE26 CRATE59)
 (ON CRATE27 PALLET4) (ON CRATE28 CRATE7) (ON CRATE29 CRATE36)
 (ON CRATE30 PALLET15) (ON CRATE31 CRATE1) (ON CRATE32 CRATE54)
 (ON CRATE33 CRATE51) (ON CRATE36 CRATE27) (ON CRATE39 PALLET12)
 (ON CRATE40 PALLET0) (ON CRATE41 CRATE40) (ON CRATE42 PALLET14)
 (ON CRATE43 CRATE55) (ON CRATE44 CRATE17) (ON CRATE45 CRATE26)
 (ON CRATE46 CRATE43) (ON CRATE48 CRATE15) (ON CRATE50 PALLET6)
 (ON CRATE51 CRATE45) (ON CRATE52 CRATE25) (ON CRATE53 CRATE23)
 (ON CRATE54 CRATE48) (ON CRATE55 CRATE58) (ON CRATE56 CRATE19)
 (ON CRATE57 CRATE20) (ON CRATE58 CRATE24) (ON CRATE59 PALLET11)
 (ON CRATE60 PALLET5) (ON CRATE61 CRATE30) (ON CRATE62 CRATE11)
 (ON CRATE63 CRATE28)))