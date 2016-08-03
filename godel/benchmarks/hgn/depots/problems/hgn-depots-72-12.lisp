(in-package :shop2)
(defproblem DEPOTPROB120 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE61) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE62) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE40)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE63) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE65) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE60)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE66) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE45) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE70)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DISTRIBUTOR0)
  (CLEAR CRATE38) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR1) (CLEAR CRATE68) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR2) (CLEAR CRATE54)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR3)
  (CLEAR CRATE56) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR4) (CLEAR CRATE64) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR5) (CLEAR CRATE59)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR6)
  (CLEAR CRATE50) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR7) (CLEAR CRATE71) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR8) (CLEAR CRATE30)
  (TRUCK TRUCK0) (AT TRUCK0 DISTRIBUTOR6) (HOIST HOIST0)
  (AT HOIST0 DEPOT0) (AVAILABLE HOIST0) (HOIST HOIST1)
  (AT HOIST1 DEPOT1) (AVAILABLE HOIST1) (HOIST HOIST2)
  (AT HOIST2 DEPOT2) (AVAILABLE HOIST2) (HOIST HOIST3)
  (AT HOIST3 DEPOT3) (AVAILABLE HOIST3) (HOIST HOIST4)
  (AT HOIST4 DEPOT4) (AVAILABLE HOIST4) (HOIST HOIST5)
  (AT HOIST5 DEPOT5) (AVAILABLE HOIST5) (HOIST HOIST6)
  (AT HOIST6 DEPOT6) (AVAILABLE HOIST6) (HOIST HOIST7)
  (AT HOIST7 DEPOT7) (AVAILABLE HOIST7) (HOIST HOIST8)
  (AT HOIST8 DEPOT8) (AVAILABLE HOIST8) (HOIST HOIST9)
  (AT HOIST9 DISTRIBUTOR0) (AVAILABLE HOIST9) (HOIST HOIST10)
  (AT HOIST10 DISTRIBUTOR1) (AVAILABLE HOIST10) (HOIST HOIST11)
  (AT HOIST11 DISTRIBUTOR2) (AVAILABLE HOIST11) (HOIST HOIST12)
  (AT HOIST12 DISTRIBUTOR3) (AVAILABLE HOIST12) (HOIST HOIST13)
  (AT HOIST13 DISTRIBUTOR4) (AVAILABLE HOIST13) (HOIST HOIST14)
  (AT HOIST14 DISTRIBUTOR5) (AVAILABLE HOIST14) (HOIST HOIST15)
  (AT HOIST15 DISTRIBUTOR6) (AVAILABLE HOIST15) (HOIST HOIST16)
  (AT HOIST16 DISTRIBUTOR7) (AVAILABLE HOIST16) (HOIST HOIST17)
  (AT HOIST17 DISTRIBUTOR8) (AVAILABLE HOIST17) (CRATE CRATE0)
  (SURFACE CRATE0) (AT CRATE0 DISTRIBUTOR8) (ON CRATE0 PALLET17)
  (CRATE CRATE1) (SURFACE CRATE1) (AT CRATE1 DEPOT4)
  (ON CRATE1 PALLET4) (CRATE CRATE2) (SURFACE CRATE2)
  (AT CRATE2 DISTRIBUTOR0) (ON CRATE2 PALLET9) (CRATE CRATE3)
  (SURFACE CRATE3) (AT CRATE3 DISTRIBUTOR8) (ON CRATE3 CRATE0)
  (CRATE CRATE4) (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR6)
  (ON CRATE4 PALLET15) (CRATE CRATE5) (SURFACE CRATE5)
  (AT CRATE5 DISTRIBUTOR1) (ON CRATE5 PALLET10) (CRATE CRATE6)
  (SURFACE CRATE6) (AT CRATE6 DEPOT7) (ON CRATE6 PALLET7)
  (CRATE CRATE7) (SURFACE CRATE7) (AT CRATE7 DEPOT0)
  (ON CRATE7 PALLET0) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DEPOT2) (ON CRATE8 PALLET2) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DISTRIBUTOR4) (ON CRATE9 PALLET13)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DISTRIBUTOR4)
  (ON CRATE10 CRATE9) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DISTRIBUTOR2) (ON CRATE11 PALLET11) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DEPOT7) (ON CRATE12 CRATE6)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT5)
  (ON CRATE13 PALLET5) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR7) (ON CRATE14 PALLET16) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR5) (ON CRATE15 PALLET14)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DEPOT6)
  (ON CRATE16 PALLET6) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DEPOT0) (ON CRATE17 CRATE7) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR4) (ON CRATE18 CRATE10)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT3)
  (ON CRATE19 PALLET3) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DISTRIBUTOR7) (ON CRATE20 CRATE14) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR0) (ON CRATE21 CRATE2)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DEPOT1)
  (ON CRATE22 PALLET1) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DISTRIBUTOR5) (ON CRATE23 CRATE15) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR6) (ON CRATE24 CRATE4)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR1)
  (ON CRATE25 CRATE5) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DEPOT0) (ON CRATE26 CRATE17) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR5) (ON CRATE27 CRATE23)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DISTRIBUTOR2)
  (ON CRATE28 CRATE11) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DEPOT4) (ON CRATE29 CRATE1) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR8) (ON CRATE30 CRATE3)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DEPOT8)
  (ON CRATE31 PALLET8) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DEPOT2) (ON CRATE32 CRATE8) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DEPOT3) (ON CRATE33 CRATE19)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR0)
  (ON CRATE34 CRATE21) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DEPOT7) (ON CRATE35 CRATE12) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DEPOT2) (ON CRATE36 CRATE32)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR4)
  (ON CRATE37 CRATE18) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DISTRIBUTOR0) (ON CRATE38 CRATE34) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DEPOT8) (ON CRATE39 CRATE31)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DEPOT2)
  (ON CRATE40 CRATE36) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT0) (ON CRATE41 CRATE26) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DEPOT4) (ON CRATE42 CRATE29)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DISTRIBUTOR1)
  (ON CRATE43 CRATE25) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DEPOT0) (ON CRATE44 CRATE41) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DEPOT7) (ON CRATE45 CRATE35)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR7)
  (ON CRATE46 CRATE20) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DEPOT4) (ON CRATE47 CRATE42) (CRATE CRATE48)
  (SURFACE CRATE48) (AT CRATE48 DEPOT6) (ON CRATE48 CRATE16)
  (CRATE CRATE49) (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR6)
  (ON CRATE49 CRATE24) (CRATE CRATE50) (SURFACE CRATE50)
  (AT CRATE50 DISTRIBUTOR6) (ON CRATE50 CRATE49) (CRATE CRATE51)
  (SURFACE CRATE51) (AT CRATE51 DEPOT4) (ON CRATE51 CRATE47)
  (CRATE CRATE52) (SURFACE CRATE52) (AT CRATE52 DEPOT5)
  (ON CRATE52 CRATE13) (CRATE CRATE53) (SURFACE CRATE53)
  (AT CRATE53 DEPOT4) (ON CRATE53 CRATE51) (CRATE CRATE54)
  (SURFACE CRATE54) (AT CRATE54 DISTRIBUTOR2) (ON CRATE54 CRATE28)
  (CRATE CRATE55) (SURFACE CRATE55) (AT CRATE55 DEPOT3)
  (ON CRATE55 CRATE33) (CRATE CRATE56) (SURFACE CRATE56)
  (AT CRATE56 DISTRIBUTOR3) (ON CRATE56 PALLET12) (CRATE CRATE57)
  (SURFACE CRATE57) (AT CRATE57 DISTRIBUTOR7) (ON CRATE57 CRATE46)
  (CRATE CRATE58) (SURFACE CRATE58) (AT CRATE58 DEPOT1)
  (ON CRATE58 CRATE22) (CRATE CRATE59) (SURFACE CRATE59)
  (AT CRATE59 DISTRIBUTOR5) (ON CRATE59 CRATE27) (CRATE CRATE60)
  (SURFACE CRATE60) (AT CRATE60 DEPOT5) (ON CRATE60 CRATE52)
  (CRATE CRATE61) (SURFACE CRATE61) (AT CRATE61 DEPOT0)
  (ON CRATE61 CRATE44) (CRATE CRATE62) (SURFACE CRATE62)
  (AT CRATE62 DEPOT1) (ON CRATE62 CRATE58) (CRATE CRATE63)
  (SURFACE CRATE63) (AT CRATE63 DEPOT3) (ON CRATE63 CRATE55)
  (CRATE CRATE64) (SURFACE CRATE64) (AT CRATE64 DISTRIBUTOR4)
  (ON CRATE64 CRATE37) (CRATE CRATE65) (SURFACE CRATE65)
  (AT CRATE65 DEPOT4) (ON CRATE65 CRATE53) (CRATE CRATE66)
  (SURFACE CRATE66) (AT CRATE66 DEPOT6) (ON CRATE66 CRATE48)
  (CRATE CRATE67) (SURFACE CRATE67) (AT CRATE67 DISTRIBUTOR1)
  (ON CRATE67 CRATE43) (CRATE CRATE68) (SURFACE CRATE68)
  (AT CRATE68 DISTRIBUTOR1) (ON CRATE68 CRATE67) (CRATE CRATE69)
  (SURFACE CRATE69) (AT CRATE69 DEPOT8) (ON CRATE69 CRATE39)
  (CRATE CRATE70) (SURFACE CRATE70) (AT CRATE70 DEPOT8)
  (ON CRATE70 CRATE69) (CRATE CRATE71) (SURFACE CRATE71)
  (AT CRATE71 DISTRIBUTOR7) (ON CRATE71 CRATE57) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7) (PLACE DEPOT8)
  (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2)
  (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5)
  (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7) (PLACE DISTRIBUTOR8)) 
 
 ;; goal 
((ON CRATE1 PALLET13) (ON CRATE2 CRATE3) (ON CRATE3 CRATE70)
 (ON CRATE4 PALLET7) (ON CRATE5 CRATE29) (ON CRATE6 PALLET17)
 (ON CRATE7 CRATE35) (ON CRATE8 CRATE7) (ON CRATE9 CRATE26)
 (ON CRATE10 CRATE46) (ON CRATE12 CRATE69) (ON CRATE13 CRATE45)
 (ON CRATE14 PALLET15) (ON CRATE15 PALLET1) (ON CRATE16 PALLET14)
 (ON CRATE17 CRATE59) (ON CRATE18 CRATE5) (ON CRATE19 CRATE6)
 (ON CRATE20 CRATE67) (ON CRATE22 CRATE24) (ON CRATE23 CRATE71)
 (ON CRATE24 PALLET10) (ON CRATE25 CRATE62) (ON CRATE26 CRATE43)
 (ON CRATE27 CRATE8) (ON CRATE28 CRATE66) (ON CRATE29 PALLET8)
 (ON CRATE30 CRATE19) (ON CRATE31 CRATE25) (ON CRATE32 CRATE40)
 (ON CRATE33 CRATE27) (ON CRATE34 CRATE58) (ON CRATE35 CRATE38)
 (ON CRATE36 CRATE41) (ON CRATE37 CRATE20) (ON CRATE38 PALLET4)
 (ON CRATE39 CRATE9) (ON CRATE40 CRATE36) (ON CRATE41 PALLET3)
 (ON CRATE42 CRATE61) (ON CRATE43 PALLET6) (ON CRATE44 CRATE60)
 (ON CRATE45 CRATE1) (ON CRATE46 CRATE44) (ON CRATE47 CRATE12)
 (ON CRATE50 CRATE68) (ON CRATE52 PALLET9) (ON CRATE53 CRATE16)
 (ON CRATE55 CRATE50) (ON CRATE56 CRATE52) (ON CRATE57 CRATE14)
 (ON CRATE58 CRATE53) (ON CRATE59 PALLET2) (ON CRATE60 CRATE37)
 (ON CRATE61 CRATE15) (ON CRATE62 CRATE63) (ON CRATE63 CRATE2)
 (ON CRATE64 CRATE34) (ON CRATE65 CRATE55) (ON CRATE66 PALLET16)
 (ON CRATE67 PALLET5) (ON CRATE68 PALLET11) (ON CRATE69 PALLET12)
 (ON CRATE70 PALLET0) (ON CRATE71 CRATE30)))