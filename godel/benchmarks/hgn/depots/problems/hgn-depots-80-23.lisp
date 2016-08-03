(in-package :shop2)
(defproblem DEPOTPROB230 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE79) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE23) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE54)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE56) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE70) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE71)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE76) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE74) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE78)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DEPOT9)
  (CLEAR CRATE59) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR0) (CLEAR CRATE51) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR1) (CLEAR CRATE33)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR2)
  (CLEAR CRATE60) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR3) (CLEAR CRATE67) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR4) (CLEAR CRATE35)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR5)
  (CLEAR CRATE72) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR6) (CLEAR CRATE68) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR7) (CLEAR CRATE75)
  (PALLET PALLET18) (SURFACE PALLET18) (AT PALLET18 DISTRIBUTOR8)
  (CLEAR CRATE66) (PALLET PALLET19) (SURFACE PALLET19)
  (AT PALLET19 DISTRIBUTOR9) (CLEAR CRATE50) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR8) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DEPOT8) (ON CRATE0 PALLET8) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DISTRIBUTOR5) (ON CRATE1 PALLET15)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DISTRIBUTOR9)
  (ON CRATE2 PALLET19) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DISTRIBUTOR6) (ON CRATE3 PALLET16) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT7) (ON CRATE4 PALLET7)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR8)
  (ON CRATE5 PALLET18) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT7) (ON CRATE6 CRATE4) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DEPOT6) (ON CRATE7 PALLET6) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR6) (ON CRATE8 CRATE3)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT4)
  (ON CRATE9 PALLET4) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT4) (ON CRATE10 CRATE9) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR9) (ON CRATE11 CRATE2)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DEPOT6)
  (ON CRATE12 CRATE7) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR6) (ON CRATE13 CRATE8) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR4) (ON CRATE14 PALLET14)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DISTRIBUTOR7)
  (ON CRATE15 PALLET17) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DISTRIBUTOR2) (ON CRATE16 PALLET12) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR8) (ON CRATE17 CRATE5)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR4)
  (ON CRATE18 CRATE14) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DEPOT2) (ON CRATE19 PALLET2) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DEPOT1) (ON CRATE20 PALLET1)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR2)
  (ON CRATE21 CRATE16) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR3) (ON CRATE22 PALLET13) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DEPOT1) (ON CRATE23 CRATE20)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR3)
  (ON CRATE24 CRATE22) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DISTRIBUTOR8) (ON CRATE25 CRATE17) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DEPOT3) (ON CRATE26 PALLET3)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR6)
  (ON CRATE27 CRATE13) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DISTRIBUTOR4) (ON CRATE28 CRATE18) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DEPOT6) (ON CRATE29 CRATE12)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DEPOT6)
  (ON CRATE30 CRATE29) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DISTRIBUTOR1) (ON CRATE31 PALLET11) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DISTRIBUTOR7) (ON CRATE32 CRATE15)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR1)
  (ON CRATE33 CRATE31) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DEPOT4) (ON CRATE34 CRATE10) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DISTRIBUTOR4) (ON CRATE35 CRATE28)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DISTRIBUTOR5)
  (ON CRATE36 CRATE1) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR5) (ON CRATE37 CRATE36) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DEPOT6) (ON CRATE38 CRATE30)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DEPOT0)
  (ON CRATE39 PALLET0) (CRATE CRATE40) (SURFACE CRATE40)
  (AT CRATE40 DEPOT3) (ON CRATE40 CRATE26) (CRATE CRATE41)
  (SURFACE CRATE41) (AT CRATE41 DISTRIBUTOR7) (ON CRATE41 CRATE32)
  (CRATE CRATE42) (SURFACE CRATE42) (AT CRATE42 DISTRIBUTOR5)
  (ON CRATE42 CRATE37) (CRATE CRATE43) (SURFACE CRATE43)
  (AT CRATE43 DISTRIBUTOR6) (ON CRATE43 CRATE27) (CRATE CRATE44)
  (SURFACE CRATE44) (AT CRATE44 DEPOT7) (ON CRATE44 CRATE6)
  (CRATE CRATE45) (SURFACE CRATE45) (AT CRATE45 DISTRIBUTOR8)
  (ON CRATE45 CRATE25) (CRATE CRATE46) (SURFACE CRATE46)
  (AT CRATE46 DEPOT8) (ON CRATE46 CRATE0) (CRATE CRATE47)
  (SURFACE CRATE47) (AT CRATE47 DISTRIBUTOR3) (ON CRATE47 CRATE24)
  (CRATE CRATE48) (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR9)
  (ON CRATE48 CRATE11) (CRATE CRATE49) (SURFACE CRATE49)
  (AT CRATE49 DISTRIBUTOR8) (ON CRATE49 CRATE45) (CRATE CRATE50)
  (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR9) (ON CRATE50 CRATE48)
  (CRATE CRATE51) (SURFACE CRATE51) (AT CRATE51 DISTRIBUTOR0)
  (ON CRATE51 PALLET10) (CRATE CRATE52) (SURFACE CRATE52)
  (AT CRATE52 DEPOT0) (ON CRATE52 CRATE39) (CRATE CRATE53)
  (SURFACE CRATE53) (AT CRATE53 DEPOT5) (ON CRATE53 PALLET5)
  (CRATE CRATE54) (SURFACE CRATE54) (AT CRATE54 DEPOT2)
  (ON CRATE54 CRATE19) (CRATE CRATE55) (SURFACE CRATE55)
  (AT CRATE55 DEPOT6) (ON CRATE55 CRATE38) (CRATE CRATE56)
  (SURFACE CRATE56) (AT CRATE56 DEPOT3) (ON CRATE56 CRATE40)
  (CRATE CRATE57) (SURFACE CRATE57) (AT CRATE57 DISTRIBUTOR2)
  (ON CRATE57 CRATE21) (CRATE CRATE58) (SURFACE CRATE58)
  (AT CRATE58 DISTRIBUTOR7) (ON CRATE58 CRATE41) (CRATE CRATE59)
  (SURFACE CRATE59) (AT CRATE59 DEPOT9) (ON CRATE59 PALLET9)
  (CRATE CRATE60) (SURFACE CRATE60) (AT CRATE60 DISTRIBUTOR2)
  (ON CRATE60 CRATE57) (CRATE CRATE61) (SURFACE CRATE61)
  (AT CRATE61 DISTRIBUTOR8) (ON CRATE61 CRATE49) (CRATE CRATE62)
  (SURFACE CRATE62) (AT CRATE62 DISTRIBUTOR7) (ON CRATE62 CRATE58)
  (CRATE CRATE63) (SURFACE CRATE63) (AT CRATE63 DEPOT6)
  (ON CRATE63 CRATE55) (CRATE CRATE64) (SURFACE CRATE64)
  (AT CRATE64 DISTRIBUTOR7) (ON CRATE64 CRATE62) (CRATE CRATE65)
  (SURFACE CRATE65) (AT CRATE65 DEPOT0) (ON CRATE65 CRATE52)
  (CRATE CRATE66) (SURFACE CRATE66) (AT CRATE66 DISTRIBUTOR8)
  (ON CRATE66 CRATE61) (CRATE CRATE67) (SURFACE CRATE67)
  (AT CRATE67 DISTRIBUTOR3) (ON CRATE67 CRATE47) (CRATE CRATE68)
  (SURFACE CRATE68) (AT CRATE68 DISTRIBUTOR6) (ON CRATE68 CRATE43)
  (CRATE CRATE69) (SURFACE CRATE69) (AT CRATE69 DEPOT5)
  (ON CRATE69 CRATE53) (CRATE CRATE70) (SURFACE CRATE70)
  (AT CRATE70 DEPOT4) (ON CRATE70 CRATE34) (CRATE CRATE71)
  (SURFACE CRATE71) (AT CRATE71 DEPOT5) (ON CRATE71 CRATE69)
  (CRATE CRATE72) (SURFACE CRATE72) (AT CRATE72 DISTRIBUTOR5)
  (ON CRATE72 CRATE42) (CRATE CRATE73) (SURFACE CRATE73)
  (AT CRATE73 DEPOT8) (ON CRATE73 CRATE46) (CRATE CRATE74)
  (SURFACE CRATE74) (AT CRATE74 DEPOT7) (ON CRATE74 CRATE44)
  (CRATE CRATE75) (SURFACE CRATE75) (AT CRATE75 DISTRIBUTOR7)
  (ON CRATE75 CRATE64) (CRATE CRATE76) (SURFACE CRATE76)
  (AT CRATE76 DEPOT6) (ON CRATE76 CRATE63) (CRATE CRATE77)
  (SURFACE CRATE77) (AT CRATE77 DEPOT0) (ON CRATE77 CRATE65)
  (CRATE CRATE78) (SURFACE CRATE78) (AT CRATE78 DEPOT8)
  (ON CRATE78 CRATE73) (CRATE CRATE79) (SURFACE CRATE79)
  (AT CRATE79 DEPOT0) (ON CRATE79 CRATE77) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7) (PLACE DEPOT8)
  (PLACE DEPOT9) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)
  (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7)
  (PLACE DISTRIBUTOR8) (PLACE DISTRIBUTOR9)) 
 
 ;; goal 
((ON CRATE0 CRATE69) (ON CRATE1 PALLET5) (ON CRATE2 CRATE63)
 (ON CRATE3 CRATE75) (ON CRATE4 CRATE10) (ON CRATE6 PALLET3)
 (ON CRATE7 CRATE4) (ON CRATE8 CRATE18) (ON CRATE9 CRATE54)
 (ON CRATE10 PALLET4) (ON CRATE11 CRATE78) (ON CRATE12 CRATE76)
 (ON CRATE14 CRATE43) (ON CRATE16 CRATE26) (ON CRATE17 CRATE77)
 (ON CRATE18 PALLET16) (ON CRATE19 CRATE28) (ON CRATE20 CRATE53)
 (ON CRATE21 PALLET14) (ON CRATE22 PALLET11) (ON CRATE23 CRATE74)
 (ON CRATE24 CRATE51) (ON CRATE25 CRATE35) (ON CRATE26 PALLET6)
 (ON CRATE27 CRATE1) (ON CRATE28 PALLET7) (ON CRATE29 CRATE73)
 (ON CRATE30 CRATE19) (ON CRATE31 PALLET2) (ON CRATE32 CRATE11)
 (ON CRATE33 CRATE8) (ON CRATE34 PALLET0) (ON CRATE35 CRATE56)
 (ON CRATE36 CRATE6) (ON CRATE37 PALLET15) (ON CRATE39 PALLET12)
 (ON CRATE40 CRATE24) (ON CRATE41 CRATE22) (ON CRATE42 CRATE29)
 (ON CRATE43 CRATE70) (ON CRATE44 CRATE32) (ON CRATE46 CRATE72)
 (ON CRATE47 PALLET17) (ON CRATE48 CRATE34) (ON CRATE49 CRATE48)
 (ON CRATE50 CRATE14) (ON CRATE51 PALLET19) (ON CRATE52 CRATE64)
 (ON CRATE53 CRATE9) (ON CRATE54 CRATE66) (ON CRATE55 PALLET9)
 (ON CRATE56 CRATE60) (ON CRATE60 CRATE61) (ON CRATE61 PALLET10)
 (ON CRATE62 CRATE50) (ON CRATE63 CRATE39) (ON CRATE64 CRATE36)
 (ON CRATE66 PALLET8) (ON CRATE68 CRATE55) (ON CRATE69 CRATE41)
 (ON CRATE70 CRATE49) (ON CRATE71 CRATE21) (ON CRATE72 CRATE68)
 (ON CRATE73 CRATE37) (ON CRATE74 CRATE17) (ON CRATE75 CRATE25)
 (ON CRATE76 CRATE33) (ON CRATE77 PALLET1) (ON CRATE78 PALLET18)))