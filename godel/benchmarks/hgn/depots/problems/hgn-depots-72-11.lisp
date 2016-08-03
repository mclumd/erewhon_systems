(in-package :shop2)
(defproblem DEPOTPROB110 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE55) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR PALLET1) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE43)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE48) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE66) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE58)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE70) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE71) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE65)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR0)
  (CLEAR CRATE68) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR1) (CLEAR CRATE57) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR2) (CLEAR CRATE69)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR3)
  (CLEAR CRATE24) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR4) (CLEAR CRATE61) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR5) (CLEAR CRATE52)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR6)
  (CLEAR CRATE56) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR7) (CLEAR CRATE53) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR8) (CLEAR CRATE64)
  (TRUCK TRUCK0) (AT TRUCK0 DEPOT0) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DEPOT3)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DEPOT4)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DEPOT5)
  (AVAILABLE HOIST5) (HOIST HOIST6) (AT HOIST6 DEPOT6)
  (AVAILABLE HOIST6) (HOIST HOIST7) (AT HOIST7 DEPOT7)
  (AVAILABLE HOIST7) (HOIST HOIST8) (AT HOIST8 DEPOT8)
  (AVAILABLE HOIST8) (HOIST HOIST9) (AT HOIST9 DISTRIBUTOR0)
  (AVAILABLE HOIST9) (HOIST HOIST10) (AT HOIST10 DISTRIBUTOR1)
  (AVAILABLE HOIST10) (HOIST HOIST11) (AT HOIST11 DISTRIBUTOR2)
  (AVAILABLE HOIST11) (HOIST HOIST12) (AT HOIST12 DISTRIBUTOR3)
  (AVAILABLE HOIST12) (HOIST HOIST13) (AT HOIST13 DISTRIBUTOR4)
  (AVAILABLE HOIST13) (HOIST HOIST14) (AT HOIST14 DISTRIBUTOR5)
  (AVAILABLE HOIST14) (HOIST HOIST15) (AT HOIST15 DISTRIBUTOR6)
  (AVAILABLE HOIST15) (HOIST HOIST16) (AT HOIST16 DISTRIBUTOR7)
  (AVAILABLE HOIST16) (HOIST HOIST17) (AT HOIST17 DISTRIBUTOR8)
  (AVAILABLE HOIST17) (CRATE CRATE0) (SURFACE CRATE0)
  (AT CRATE0 DEPOT5) (ON CRATE0 PALLET5) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR1) (ON CRATE1 PALLET10)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR2)
  (ON CRATE2 PALLET11) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DISTRIBUTOR6) (ON CRATE3 PALLET15) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT8) (ON CRATE4 PALLET8)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT4)
  (ON CRATE5 PALLET4) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DISTRIBUTOR4) (ON CRATE6 PALLET13) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DEPOT4) (ON CRATE7 CRATE5) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR4) (ON CRATE8 CRATE6)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT5) (ON CRATE9 CRATE0)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DEPOT3)
  (ON CRATE10 PALLET3) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT0) (ON CRATE11 PALLET0) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DEPOT2) (ON CRATE12 PALLET2)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DISTRIBUTOR2)
  (ON CRATE13 CRATE2) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DEPOT3) (ON CRATE14 CRATE10) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR0) (ON CRATE15 PALLET9)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DEPOT6)
  (ON CRATE16 PALLET6) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DISTRIBUTOR1) (ON CRATE17 CRATE1) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR5) (ON CRATE18 PALLET14)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT8)
  (ON CRATE19 CRATE4) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT7) (ON CRATE20 PALLET7) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR7) (ON CRATE21 PALLET16)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR1)
  (ON CRATE22 CRATE17) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DEPOT3) (ON CRATE23 CRATE14) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR3) (ON CRATE24 PALLET12)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DEPOT3)
  (ON CRATE25 CRATE23) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DISTRIBUTOR8) (ON CRATE26 PALLET17) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DEPOT8) (ON CRATE27 CRATE19)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DEPOT3)
  (ON CRATE28 CRATE25) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DISTRIBUTOR7) (ON CRATE29 CRATE21) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DEPOT7) (ON CRATE30 CRATE20)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DISTRIBUTOR6)
  (ON CRATE31 CRATE3) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DISTRIBUTOR2) (ON CRATE32 CRATE13) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR5) (ON CRATE33 CRATE18)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR6)
  (ON CRATE34 CRATE31) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DISTRIBUTOR2) (ON CRATE35 CRATE32) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DEPOT0) (ON CRATE36 CRATE11)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DEPOT7)
  (ON CRATE37 CRATE30) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DISTRIBUTOR4) (ON CRATE38 CRATE8) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR6) (ON CRATE39 CRATE34)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DEPOT2)
  (ON CRATE40 CRATE12) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT7) (ON CRATE41 CRATE37) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DEPOT4) (ON CRATE42 CRATE7)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DEPOT2)
  (ON CRATE43 CRATE40) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DEPOT0) (ON CRATE44 CRATE36) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DISTRIBUTOR6) (ON CRATE45 CRATE39)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR0)
  (ON CRATE46 CRATE15) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DEPOT3) (ON CRATE47 CRATE28) (CRATE CRATE48)
  (SURFACE CRATE48) (AT CRATE48 DEPOT3) (ON CRATE48 CRATE47)
  (CRATE CRATE49) (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR1)
  (ON CRATE49 CRATE22) (CRATE CRATE50) (SURFACE CRATE50)
  (AT CRATE50 DEPOT5) (ON CRATE50 CRATE9) (CRATE CRATE51)
  (SURFACE CRATE51) (AT CRATE51 DEPOT5) (ON CRATE51 CRATE50)
  (CRATE CRATE52) (SURFACE CRATE52) (AT CRATE52 DISTRIBUTOR5)
  (ON CRATE52 CRATE33) (CRATE CRATE53) (SURFACE CRATE53)
  (AT CRATE53 DISTRIBUTOR7) (ON CRATE53 CRATE29) (CRATE CRATE54)
  (SURFACE CRATE54) (AT CRATE54 DEPOT6) (ON CRATE54 CRATE16)
  (CRATE CRATE55) (SURFACE CRATE55) (AT CRATE55 DEPOT0)
  (ON CRATE55 CRATE44) (CRATE CRATE56) (SURFACE CRATE56)
  (AT CRATE56 DISTRIBUTOR6) (ON CRATE56 CRATE45) (CRATE CRATE57)
  (SURFACE CRATE57) (AT CRATE57 DISTRIBUTOR1) (ON CRATE57 CRATE49)
  (CRATE CRATE58) (SURFACE CRATE58) (AT CRATE58 DEPOT5)
  (ON CRATE58 CRATE51) (CRATE CRATE59) (SURFACE CRATE59)
  (AT CRATE59 DISTRIBUTOR2) (ON CRATE59 CRATE35) (CRATE CRATE60)
  (SURFACE CRATE60) (AT CRATE60 DISTRIBUTOR4) (ON CRATE60 CRATE38)
  (CRATE CRATE61) (SURFACE CRATE61) (AT CRATE61 DISTRIBUTOR4)
  (ON CRATE61 CRATE60) (CRATE CRATE62) (SURFACE CRATE62)
  (AT CRATE62 DEPOT4) (ON CRATE62 CRATE42) (CRATE CRATE63)
  (SURFACE CRATE63) (AT CRATE63 DEPOT8) (ON CRATE63 CRATE27)
  (CRATE CRATE64) (SURFACE CRATE64) (AT CRATE64 DISTRIBUTOR8)
  (ON CRATE64 CRATE26) (CRATE CRATE65) (SURFACE CRATE65)
  (AT CRATE65 DEPOT8) (ON CRATE65 CRATE63) (CRATE CRATE66)
  (SURFACE CRATE66) (AT CRATE66 DEPOT4) (ON CRATE66 CRATE62)
  (CRATE CRATE67) (SURFACE CRATE67) (AT CRATE67 DISTRIBUTOR2)
  (ON CRATE67 CRATE59) (CRATE CRATE68) (SURFACE CRATE68)
  (AT CRATE68 DISTRIBUTOR0) (ON CRATE68 CRATE46) (CRATE CRATE69)
  (SURFACE CRATE69) (AT CRATE69 DISTRIBUTOR2) (ON CRATE69 CRATE67)
  (CRATE CRATE70) (SURFACE CRATE70) (AT CRATE70 DEPOT6)
  (ON CRATE70 CRATE54) (CRATE CRATE71) (SURFACE CRATE71)
  (AT CRATE71 DEPOT7) (ON CRATE71 CRATE41) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7) (PLACE DEPOT8)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)
  (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5)
  (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7) (PLACE DISTRIBUTOR8)) 
 
 ;; goal 
((ON CRATE0 CRATE50) (ON CRATE1 CRATE25) (ON CRATE4 CRATE33)
 (ON CRATE5 CRATE68) (ON CRATE6 CRATE62) (ON CRATE7 CRATE58)
 (ON CRATE8 CRATE24) (ON CRATE9 PALLET15) (ON CRATE10 CRATE40)
 (ON CRATE11 CRATE52) (ON CRATE12 PALLET16) (ON CRATE13 CRATE17)
 (ON CRATE14 CRATE15) (ON CRATE15 PALLET2) (ON CRATE16 CRATE27)
 (ON CRATE17 CRATE38) (ON CRATE19 CRATE42) (ON CRATE21 CRATE30)
 (ON CRATE22 CRATE39) (ON CRATE24 CRATE22) (ON CRATE25 CRATE51)
 (ON CRATE26 CRATE71) (ON CRATE27 CRATE43) (ON CRATE28 CRATE1)
 (ON CRATE29 CRATE31) (ON CRATE30 PALLET8) (ON CRATE31 CRATE7)
 (ON CRATE32 PALLET11) (ON CRATE33 PALLET10) (ON CRATE36 CRATE69)
 (ON CRATE37 CRATE54) (ON CRATE38 PALLET4) (ON CRATE39 CRATE65)
 (ON CRATE40 PALLET13) (ON CRATE41 CRATE14) (ON CRATE42 CRATE63)
 (ON CRATE43 CRATE70) (ON CRATE44 CRATE4) (ON CRATE46 CRATE41)
 (ON CRATE47 CRATE29) (ON CRATE48 PALLET1) (ON CRATE49 CRATE19)
 (ON CRATE50 CRATE60) (ON CRATE51 PALLET17) (ON CRATE52 PALLET9)
 (ON CRATE54 CRATE61) (ON CRATE57 CRATE64) (ON CRATE58 CRATE36)
 (ON CRATE59 CRATE13) (ON CRATE60 CRATE12) (ON CRATE61 CRATE16)
 (ON CRATE62 PALLET7) (ON CRATE63 PALLET3) (ON CRATE64 CRATE21)
 (ON CRATE65 PALLET0) (ON CRATE66 PALLET5) (ON CRATE68 CRATE32)
 (ON CRATE69 PALLET6) (ON CRATE70 PALLET14) (ON CRATE71 CRATE48)))