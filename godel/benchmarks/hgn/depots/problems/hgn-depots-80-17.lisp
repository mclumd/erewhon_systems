(in-package :shop2)
(defproblem DEPOTPROB170 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE74) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE62) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE50)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE72) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE67) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE70)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE46) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE58) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE78)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DEPOT9)
  (CLEAR CRATE34) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR0) (CLEAR CRATE79) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR1) (CLEAR CRATE49)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR2)
  (CLEAR CRATE65) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR3) (CLEAR CRATE40) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR4) (CLEAR CRATE68)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR5)
  (CLEAR CRATE66) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR6) (CLEAR CRATE76) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR7) (CLEAR CRATE55)
  (PALLET PALLET18) (SURFACE PALLET18) (AT PALLET18 DISTRIBUTOR8)
  (CLEAR CRATE71) (PALLET PALLET19) (SURFACE PALLET19)
  (AT PALLET19 DISTRIBUTOR9) (CLEAR CRATE59) (TRUCK TRUCK0)
  (AT TRUCK0 DEPOT2) (HOIST HOIST0) (AT HOIST0 DEPOT0)
  (AVAILABLE HOIST0) (HOIST HOIST1) (AT HOIST1 DEPOT1)
  (AVAILABLE HOIST1) (HOIST HOIST2) (AT HOIST2 DEPOT2)
  (AVAILABLE HOIST2) (HOIST HOIST3) (AT HOIST3 DEPOT3)
  (AVAILABLE HOIST3) (HOIST HOIST4) (AT HOIST4 DEPOT4)
  (AVAILABLE HOIST4) (HOIST HOIST5) (AT HOIST5 DEPOT5)
  (AVAILABLE HOIST5) (HOIST HOIST6) (AT HOIST6 DEPOT6)
  (AVAILABLE HOIST6) (HOIST HOIST7) (AT HOIST7 DEPOT7)
  (AVAILABLE HOIST7) (HOIST HOIST8) (AT HOIST8 DEPOT8)
  (AVAILABLE HOIST8) (HOIST HOIST9) (AT HOIST9 DEPOT9)
  (AVAILABLE HOIST9) (HOIST HOIST10) (AT HOIST10 DISTRIBUTOR0)
  (AVAILABLE HOIST10) (HOIST HOIST11) (AT HOIST11 DISTRIBUTOR1)
  (AVAILABLE HOIST11) (HOIST HOIST12) (AT HOIST12 DISTRIBUTOR2)
  (AVAILABLE HOIST12) (HOIST HOIST13) (AT HOIST13 DISTRIBUTOR3)
  (AVAILABLE HOIST13) (HOIST HOIST14) (AT HOIST14 DISTRIBUTOR4)
  (AVAILABLE HOIST14) (HOIST HOIST15) (AT HOIST15 DISTRIBUTOR5)
  (AVAILABLE HOIST15) (HOIST HOIST16) (AT HOIST16 DISTRIBUTOR6)
  (AVAILABLE HOIST16) (HOIST HOIST17) (AT HOIST17 DISTRIBUTOR7)
  (AVAILABLE HOIST17) (HOIST HOIST18) (AT HOIST18 DISTRIBUTOR8)
  (AVAILABLE HOIST18) (HOIST HOIST19) (AT HOIST19 DISTRIBUTOR9)
  (AVAILABLE HOIST19) (CRATE CRATE0) (SURFACE CRATE0)
  (AT CRATE0 DEPOT0) (ON CRATE0 PALLET0) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR7) (ON CRATE1 PALLET17)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT6)
  (ON CRATE2 PALLET6) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT9) (ON CRATE3 PALLET9) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT0) (ON CRATE4 CRATE0) (CRATE CRATE5)
  (SURFACE CRATE5) (AT CRATE5 DEPOT2) (ON CRATE5 PALLET2)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DEPOT4)
  (ON CRATE6 PALLET4) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DEPOT0) (ON CRATE7 CRATE4) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DISTRIBUTOR0) (ON CRATE8 PALLET10) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DEPOT4) (ON CRATE9 CRATE6)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DEPOT5)
  (ON CRATE10 PALLET5) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT1) (ON CRATE11 PALLET1) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR4) (ON CRATE12 PALLET14)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT3)
  (ON CRATE13 PALLET3) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR0) (ON CRATE14 CRATE8) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DEPOT8) (ON CRATE15 PALLET8)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DEPOT6)
  (ON CRATE16 CRATE2) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DEPOT4) (ON CRATE17 CRATE9) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR0) (ON CRATE18 CRATE14)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DEPOT5)
  (ON CRATE19 CRATE10) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DISTRIBUTOR2) (ON CRATE20 PALLET12) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR7) (ON CRATE21 CRATE1)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DISTRIBUTOR4)
  (ON CRATE22 CRATE12) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DEPOT4) (ON CRATE23 CRATE17) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DEPOT2) (ON CRATE24 CRATE5)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DEPOT2)
  (ON CRATE25 CRATE24) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DEPOT1) (ON CRATE26 CRATE11) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DEPOT2) (ON CRATE27 CRATE25)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DEPOT7)
  (ON CRATE28 PALLET7) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DEPOT2) (ON CRATE29 CRATE27) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR9) (ON CRATE30 PALLET19)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DEPOT9)
  (ON CRATE31 CRATE3) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DISTRIBUTOR7) (ON CRATE32 CRATE21) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR9) (ON CRATE33 CRATE30)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DEPOT9)
  (ON CRATE34 CRATE31) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DISTRIBUTOR9) (ON CRATE35 CRATE33) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DISTRIBUTOR3) (ON CRATE36 PALLET13)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR9)
  (ON CRATE37 CRATE35) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DISTRIBUTOR3) (ON CRATE38 CRATE36) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR2) (ON CRATE39 CRATE20)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DISTRIBUTOR3)
  (ON CRATE40 CRATE38) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT4) (ON CRATE41 CRATE23) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DISTRIBUTOR9) (ON CRATE42 CRATE37)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DISTRIBUTOR2)
  (ON CRATE43 CRATE39) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DISTRIBUTOR1) (ON CRATE44 PALLET11) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DEPOT6) (ON CRATE45 CRATE16)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DEPOT6)
  (ON CRATE46 CRATE45) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DISTRIBUTOR7) (ON CRATE47 CRATE32) (CRATE CRATE48)
  (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR0) (ON CRATE48 CRATE18)
  (CRATE CRATE49) (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR1)
  (ON CRATE49 CRATE44) (CRATE CRATE50) (SURFACE CRATE50)
  (AT CRATE50 DEPOT2) (ON CRATE50 CRATE29) (CRATE CRATE51)
  (SURFACE CRATE51) (AT CRATE51 DEPOT1) (ON CRATE51 CRATE26)
  (CRATE CRATE52) (SURFACE CRATE52) (AT CRATE52 DEPOT7)
  (ON CRATE52 CRATE28) (CRATE CRATE53) (SURFACE CRATE53)
  (AT CRATE53 DEPOT4) (ON CRATE53 CRATE41) (CRATE CRATE54)
  (SURFACE CRATE54) (AT CRATE54 DEPOT4) (ON CRATE54 CRATE53)
  (CRATE CRATE55) (SURFACE CRATE55) (AT CRATE55 DISTRIBUTOR7)
  (ON CRATE55 CRATE47) (CRATE CRATE56) (SURFACE CRATE56)
  (AT CRATE56 DISTRIBUTOR2) (ON CRATE56 CRATE43) (CRATE CRATE57)
  (SURFACE CRATE57) (AT CRATE57 DISTRIBUTOR4) (ON CRATE57 CRATE22)
  (CRATE CRATE58) (SURFACE CRATE58) (AT CRATE58 DEPOT7)
  (ON CRATE58 CRATE52) (CRATE CRATE59) (SURFACE CRATE59)
  (AT CRATE59 DISTRIBUTOR9) (ON CRATE59 CRATE42) (CRATE CRATE60)
  (SURFACE CRATE60) (AT CRATE60 DEPOT1) (ON CRATE60 CRATE51)
  (CRATE CRATE61) (SURFACE CRATE61) (AT CRATE61 DISTRIBUTOR0)
  (ON CRATE61 CRATE48) (CRATE CRATE62) (SURFACE CRATE62)
  (AT CRATE62 DEPOT1) (ON CRATE62 CRATE60) (CRATE CRATE63)
  (SURFACE CRATE63) (AT CRATE63 DISTRIBUTOR2) (ON CRATE63 CRATE56)
  (CRATE CRATE64) (SURFACE CRATE64) (AT CRATE64 DEPOT5)
  (ON CRATE64 CRATE19) (CRATE CRATE65) (SURFACE CRATE65)
  (AT CRATE65 DISTRIBUTOR2) (ON CRATE65 CRATE63) (CRATE CRATE66)
  (SURFACE CRATE66) (AT CRATE66 DISTRIBUTOR5) (ON CRATE66 PALLET15)
  (CRATE CRATE67) (SURFACE CRATE67) (AT CRATE67 DEPOT4)
  (ON CRATE67 CRATE54) (CRATE CRATE68) (SURFACE CRATE68)
  (AT CRATE68 DISTRIBUTOR4) (ON CRATE68 CRATE57) (CRATE CRATE69)
  (SURFACE CRATE69) (AT CRATE69 DEPOT3) (ON CRATE69 CRATE13)
  (CRATE CRATE70) (SURFACE CRATE70) (AT CRATE70 DEPOT5)
  (ON CRATE70 CRATE64) (CRATE CRATE71) (SURFACE CRATE71)
  (AT CRATE71 DISTRIBUTOR8) (ON CRATE71 PALLET18) (CRATE CRATE72)
  (SURFACE CRATE72) (AT CRATE72 DEPOT3) (ON CRATE72 CRATE69)
  (CRATE CRATE73) (SURFACE CRATE73) (AT CRATE73 DISTRIBUTOR0)
  (ON CRATE73 CRATE61) (CRATE CRATE74) (SURFACE CRATE74)
  (AT CRATE74 DEPOT0) (ON CRATE74 CRATE7) (CRATE CRATE75)
  (SURFACE CRATE75) (AT CRATE75 DISTRIBUTOR0) (ON CRATE75 CRATE73)
  (CRATE CRATE76) (SURFACE CRATE76) (AT CRATE76 DISTRIBUTOR6)
  (ON CRATE76 PALLET16) (CRATE CRATE77) (SURFACE CRATE77)
  (AT CRATE77 DISTRIBUTOR0) (ON CRATE77 CRATE75) (CRATE CRATE78)
  (SURFACE CRATE78) (AT CRATE78 DEPOT8) (ON CRATE78 CRATE15)
  (CRATE CRATE79) (SURFACE CRATE79) (AT CRATE79 DISTRIBUTOR0)
  (ON CRATE79 CRATE77) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6)
  (PLACE DEPOT7) (PLACE DEPOT8) (PLACE DEPOT9) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)
  (PLACE DISTRIBUTOR7) (PLACE DISTRIBUTOR8) (PLACE DISTRIBUTOR9)) 
 
 ;; goal 
((ON CRATE1 CRATE8) (ON CRATE2 PALLET7) (ON CRATE3 CRATE10)
 (ON CRATE4 PALLET16) (ON CRATE5 PALLET9) (ON CRATE6 CRATE41)
 (ON CRATE7 CRATE73) (ON CRATE8 CRATE38) (ON CRATE10 CRATE21)
 (ON CRATE11 PALLET2) (ON CRATE12 CRATE70) (ON CRATE13 PALLET18)
 (ON CRATE14 PALLET12) (ON CRATE15 CRATE39) (ON CRATE16 PALLET0)
 (ON CRATE18 CRATE36) (ON CRATE19 CRATE14) (ON CRATE20 CRATE54)
 (ON CRATE21 PALLET17) (ON CRATE22 CRATE32) (ON CRATE23 CRATE19)
 (ON CRATE24 PALLET8) (ON CRATE25 CRATE58) (ON CRATE26 PALLET3)
 (ON CRATE27 CRATE68) (ON CRATE28 CRATE16) (ON CRATE29 CRATE75)
 (ON CRATE30 PALLET11) (ON CRATE31 CRATE65) (ON CRATE32 CRATE42)
 (ON CRATE33 CRATE12) (ON CRATE34 CRATE23) (ON CRATE36 CRATE30)
 (ON CRATE37 CRATE40) (ON CRATE38 CRATE5) (ON CRATE39 CRATE4)
 (ON CRATE40 CRATE26) (ON CRATE41 PALLET10) (ON CRATE42 PALLET19)
 (ON CRATE44 CRATE33) (ON CRATE45 CRATE53) (ON CRATE46 CRATE13)
 (ON CRATE47 PALLET15) (ON CRATE48 CRATE1) (ON CRATE49 PALLET4)
 (ON CRATE53 CRATE47) (ON CRATE54 PALLET5) (ON CRATE55 CRATE20)
 (ON CRATE56 PALLET6) (ON CRATE57 CRATE22) (ON CRATE58 CRATE45)
 (ON CRATE59 CRATE61) (ON CRATE60 CRATE37) (ON CRATE61 CRATE15)
 (ON CRATE62 CRATE56) (ON CRATE63 CRATE67) (ON CRATE65 CRATE24)
 (ON CRATE67 PALLET14) (ON CRATE68 PALLET1) (ON CRATE69 CRATE18)
 (ON CRATE70 CRATE60) (ON CRATE71 CRATE7) (ON CRATE73 CRATE57)
 (ON CRATE74 CRATE34) (ON CRATE75 CRATE77) (ON CRATE76 CRATE63)
 (ON CRATE77 CRATE31) (ON CRATE78 CRATE59) (ON CRATE79 CRATE3)))