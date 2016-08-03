(in-package :shop2)
(defproblem DEPOTPROB80 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE60) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE54) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE51)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE58) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE20) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE66)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE71) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE55) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE67)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR0)
  (CLEAR CRATE70) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR1) (CLEAR CRATE63) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR2) (CLEAR CRATE37)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR3)
  (CLEAR CRATE68) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR4) (CLEAR CRATE53) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR5) (CLEAR CRATE32)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR6)
  (CLEAR CRATE65) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR7) (CLEAR CRATE47) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR8) (CLEAR CRATE45)
  (TRUCK TRUCK0) (AT TRUCK0 DEPOT1) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DISTRIBUTOR4) (ON CRATE0 PALLET13) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT4) (ON CRATE1 PALLET4)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR7)
  (ON CRATE2 PALLET16) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT4) (ON CRATE3 CRATE1) (CRATE CRATE4) (SURFACE CRATE4)
  (AT CRATE4 DEPOT3) (ON CRATE4 PALLET3) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR2) (ON CRATE5 PALLET11)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DISTRIBUTOR8)
  (ON CRATE6 PALLET17) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DISTRIBUTOR0) (ON CRATE7 PALLET9) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR0) (ON CRATE8 CRATE7)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT6)
  (ON CRATE9 PALLET6) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DISTRIBUTOR1) (ON CRATE10 PALLET10) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR4) (ON CRATE11 CRATE0)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR5)
  (ON CRATE12 PALLET14) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DEPOT5) (ON CRATE13 PALLET5) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR3) (ON CRATE14 PALLET12)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DEPOT8)
  (ON CRATE15 PALLET8) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DISTRIBUTOR2) (ON CRATE16 CRATE5) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DEPOT7) (ON CRATE17 PALLET7)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR7)
  (ON CRATE18 CRATE2) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DISTRIBUTOR6) (ON CRATE19 PALLET15) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DEPOT4) (ON CRATE20 CRATE3)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DEPOT6)
  (ON CRATE21 CRATE9) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR4) (ON CRATE22 CRATE11) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR4) (ON CRATE23 CRATE22)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR0)
  (ON CRATE24 CRATE8) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DEPOT0) (ON CRATE25 PALLET0) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR8) (ON CRATE26 CRATE6)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DEPOT1)
  (ON CRATE27 PALLET1) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DISTRIBUTOR8) (ON CRATE28 CRATE26) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DISTRIBUTOR1) (ON CRATE29 CRATE10)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR8)
  (ON CRATE30 CRATE28) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DEPOT1) (ON CRATE31 CRATE27) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DISTRIBUTOR5) (ON CRATE32 CRATE12)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DEPOT2)
  (ON CRATE33 PALLET2) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DEPOT2) (ON CRATE34 CRATE33) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DISTRIBUTOR6) (ON CRATE35 CRATE19)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DEPOT8)
  (ON CRATE36 CRATE15) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR2) (ON CRATE37 CRATE16) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DEPOT2) (ON CRATE38 CRATE34)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR0)
  (ON CRATE39 CRATE24) (CRATE CRATE40) (SURFACE CRATE40)
  (AT CRATE40 DEPOT8) (ON CRATE40 CRATE36) (CRATE CRATE41)
  (SURFACE CRATE41) (AT CRATE41 DISTRIBUTOR6) (ON CRATE41 CRATE35)
  (CRATE CRATE42) (SURFACE CRATE42) (AT CRATE42 DEPOT6)
  (ON CRATE42 CRATE21) (CRATE CRATE43) (SURFACE CRATE43)
  (AT CRATE43 DEPOT3) (ON CRATE43 CRATE4) (CRATE CRATE44)
  (SURFACE CRATE44) (AT CRATE44 DEPOT6) (ON CRATE44 CRATE42)
  (CRATE CRATE45) (SURFACE CRATE45) (AT CRATE45 DISTRIBUTOR8)
  (ON CRATE45 CRATE30) (CRATE CRATE46) (SURFACE CRATE46)
  (AT CRATE46 DISTRIBUTOR6) (ON CRATE46 CRATE41) (CRATE CRATE47)
  (SURFACE CRATE47) (AT CRATE47 DISTRIBUTOR7) (ON CRATE47 CRATE18)
  (CRATE CRATE48) (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR1)
  (ON CRATE48 CRATE29) (CRATE CRATE49) (SURFACE CRATE49)
  (AT CRATE49 DEPOT7) (ON CRATE49 CRATE17) (CRATE CRATE50)
  (SURFACE CRATE50) (AT CRATE50 DEPOT1) (ON CRATE50 CRATE31)
  (CRATE CRATE51) (SURFACE CRATE51) (AT CRATE51 DEPOT2)
  (ON CRATE51 CRATE38) (CRATE CRATE52) (SURFACE CRATE52)
  (AT CRATE52 DISTRIBUTOR0) (ON CRATE52 CRATE39) (CRATE CRATE53)
  (SURFACE CRATE53) (AT CRATE53 DISTRIBUTOR4) (ON CRATE53 CRATE23)
  (CRATE CRATE54) (SURFACE CRATE54) (AT CRATE54 DEPOT1)
  (ON CRATE54 CRATE50) (CRATE CRATE55) (SURFACE CRATE55)
  (AT CRATE55 DEPOT7) (ON CRATE55 CRATE49) (CRATE CRATE56)
  (SURFACE CRATE56) (AT CRATE56 DISTRIBUTOR6) (ON CRATE56 CRATE46)
  (CRATE CRATE57) (SURFACE CRATE57) (AT CRATE57 DEPOT0)
  (ON CRATE57 CRATE25) (CRATE CRATE58) (SURFACE CRATE58)
  (AT CRATE58 DEPOT3) (ON CRATE58 CRATE43) (CRATE CRATE59)
  (SURFACE CRATE59) (AT CRATE59 DISTRIBUTOR1) (ON CRATE59 CRATE48)
  (CRATE CRATE60) (SURFACE CRATE60) (AT CRATE60 DEPOT0)
  (ON CRATE60 CRATE57) (CRATE CRATE61) (SURFACE CRATE61)
  (AT CRATE61 DISTRIBUTOR6) (ON CRATE61 CRATE56) (CRATE CRATE62)
  (SURFACE CRATE62) (AT CRATE62 DISTRIBUTOR1) (ON CRATE62 CRATE59)
  (CRATE CRATE63) (SURFACE CRATE63) (AT CRATE63 DISTRIBUTOR1)
  (ON CRATE63 CRATE62) (CRATE CRATE64) (SURFACE CRATE64)
  (AT CRATE64 DISTRIBUTOR6) (ON CRATE64 CRATE61) (CRATE CRATE65)
  (SURFACE CRATE65) (AT CRATE65 DISTRIBUTOR6) (ON CRATE65 CRATE64)
  (CRATE CRATE66) (SURFACE CRATE66) (AT CRATE66 DEPOT5)
  (ON CRATE66 CRATE13) (CRATE CRATE67) (SURFACE CRATE67)
  (AT CRATE67 DEPOT8) (ON CRATE67 CRATE40) (CRATE CRATE68)
  (SURFACE CRATE68) (AT CRATE68 DISTRIBUTOR3) (ON CRATE68 CRATE14)
  (CRATE CRATE69) (SURFACE CRATE69) (AT CRATE69 DISTRIBUTOR0)
  (ON CRATE69 CRATE52) (CRATE CRATE70) (SURFACE CRATE70)
  (AT CRATE70 DISTRIBUTOR0) (ON CRATE70 CRATE69) (CRATE CRATE71)
  (SURFACE CRATE71) (AT CRATE71 DEPOT6) (ON CRATE71 CRATE44)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3)
  (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7)
  (PLACE DEPOT8) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)
  (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7)
  (PLACE DISTRIBUTOR8)) 
 
 ;; goal 
((ON CRATE1 CRATE10) (ON CRATE2 CRATE11) (ON CRATE3 PALLET16)
 (ON CRATE4 CRATE38) (ON CRATE5 CRATE46) (ON CRATE6 CRATE48)
 (ON CRATE8 CRATE71) (ON CRATE9 PALLET8) (ON CRATE10 CRATE43)
 (ON CRATE11 PALLET0) (ON CRATE13 CRATE3) (ON CRATE15 CRATE35)
 (ON CRATE16 PALLET15) (ON CRATE19 CRATE54) (ON CRATE20 CRATE50)
 (ON CRATE21 PALLET7) (ON CRATE22 PALLET3) (ON CRATE23 CRATE52)
 (ON CRATE24 CRATE57) (ON CRATE25 PALLET11) (ON CRATE26 CRATE60)
 (ON CRATE27 PALLET12) (ON CRATE28 CRATE31) (ON CRATE29 CRATE9)
 (ON CRATE30 PALLET4) (ON CRATE31 PALLET2) (ON CRATE32 PALLET5)
 (ON CRATE33 CRATE69) (ON CRATE34 CRATE51) (ON CRATE35 PALLET6)
 (ON CRATE36 PALLET17) (ON CRATE37 PALLET14) (ON CRATE38 CRATE45)
 (ON CRATE39 CRATE33) (ON CRATE40 CRATE5) (ON CRATE41 CRATE39)
 (ON CRATE42 CRATE49) (ON CRATE43 CRATE16) (ON CRATE44 CRATE40)
 (ON CRATE45 PALLET13) (ON CRATE46 CRATE1) (ON CRATE47 CRATE65)
 (ON CRATE48 CRATE66) (ON CRATE49 CRATE13) (ON CRATE50 CRATE24)
 (ON CRATE51 CRATE30) (ON CRATE52 PALLET9) (ON CRATE54 CRATE28)
 (ON CRATE55 CRATE22) (ON CRATE56 CRATE25) (ON CRATE57 CRATE27)
 (ON CRATE58 CRATE67) (ON CRATE59 CRATE32) (ON CRATE60 CRATE56)
 (ON CRATE61 PALLET10) (ON CRATE63 CRATE59) (ON CRATE65 CRATE36)
 (ON CRATE66 CRATE4) (ON CRATE67 CRATE23) (ON CRATE69 CRATE19)
 (ON CRATE70 CRATE63) (ON CRATE71 PALLET1)))