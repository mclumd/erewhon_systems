(in-package :shop2)
(defproblem DEPOTPROB250 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE57) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE74) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE45)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE29) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE78) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE55)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE65) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE73) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE77)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DEPOT9)
  (CLEAR CRATE19) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR0) (CLEAR CRATE68) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR1) (CLEAR CRATE63)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR2)
  (CLEAR CRATE51) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR3) (CLEAR CRATE69) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR4) (CLEAR CRATE79)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR5)
  (CLEAR CRATE59) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR6) (CLEAR CRATE11) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR7) (CLEAR CRATE67)
  (PALLET PALLET18) (SURFACE PALLET18) (AT PALLET18 DISTRIBUTOR8)
  (CLEAR CRATE62) (PALLET PALLET19) (SURFACE PALLET19)
  (AT PALLET19 DISTRIBUTOR9) (CLEAR CRATE76) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR3) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DISTRIBUTOR1) (ON CRATE0 PALLET11) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT6) (ON CRATE1 PALLET6)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT2)
  (ON CRATE2 PALLET2) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DISTRIBUTOR4) (ON CRATE3 PALLET14) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT3) (ON CRATE4 PALLET3)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT5)
  (ON CRATE5 PALLET5) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT2) (ON CRATE6 CRATE2) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DISTRIBUTOR9) (ON CRATE7 PALLET19) (CRATE CRATE8)
  (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR2) (ON CRATE8 PALLET12)
  (CRATE CRATE9) (SURFACE CRATE9) (AT CRATE9 DEPOT4)
  (ON CRATE9 PALLET4) (CRATE CRATE10) (SURFACE CRATE10)
  (AT CRATE10 DEPOT0) (ON CRATE10 PALLET0) (CRATE CRATE11)
  (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR6) (ON CRATE11 PALLET16)
  (CRATE CRATE12) (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR7)
  (ON CRATE12 PALLET17) (CRATE CRATE13) (SURFACE CRATE13)
  (AT CRATE13 DISTRIBUTOR9) (ON CRATE13 CRATE7) (CRATE CRATE14)
  (SURFACE CRATE14) (AT CRATE14 DISTRIBUTOR7) (ON CRATE14 CRATE12)
  (CRATE CRATE15) (SURFACE CRATE15) (AT CRATE15 DEPOT5)
  (ON CRATE15 CRATE5) (CRATE CRATE16) (SURFACE CRATE16)
  (AT CRATE16 DEPOT9) (ON CRATE16 PALLET9) (CRATE CRATE17)
  (SURFACE CRATE17) (AT CRATE17 DISTRIBUTOR9) (ON CRATE17 CRATE13)
  (CRATE CRATE18) (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR3)
  (ON CRATE18 PALLET13) (CRATE CRATE19) (SURFACE CRATE19)
  (AT CRATE19 DEPOT9) (ON CRATE19 CRATE16) (CRATE CRATE20)
  (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR2) (ON CRATE20 CRATE8)
  (CRATE CRATE21) (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR1)
  (ON CRATE21 CRATE0) (CRATE CRATE22) (SURFACE CRATE22)
  (AT CRATE22 DISTRIBUTOR0) (ON CRATE22 PALLET10) (CRATE CRATE23)
  (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR0) (ON CRATE23 CRATE22)
  (CRATE CRATE24) (SURFACE CRATE24) (AT CRATE24 DEPOT2)
  (ON CRATE24 CRATE6) (CRATE CRATE25) (SURFACE CRATE25)
  (AT CRATE25 DEPOT4) (ON CRATE25 CRATE9) (CRATE CRATE26)
  (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR2) (ON CRATE26 CRATE20)
  (CRATE CRATE27) (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR2)
  (ON CRATE27 CRATE26) (CRATE CRATE28) (SURFACE CRATE28)
  (AT CRATE28 DISTRIBUTOR1) (ON CRATE28 CRATE21) (CRATE CRATE29)
  (SURFACE CRATE29) (AT CRATE29 DEPOT3) (ON CRATE29 CRATE4)
  (CRATE CRATE30) (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR5)
  (ON CRATE30 PALLET15) (CRATE CRATE31) (SURFACE CRATE31)
  (AT CRATE31 DISTRIBUTOR8) (ON CRATE31 PALLET18) (CRATE CRATE32)
  (SURFACE CRATE32) (AT CRATE32 DEPOT1) (ON CRATE32 PALLET1)
  (CRATE CRATE33) (SURFACE CRATE33) (AT CRATE33 DISTRIBUTOR7)
  (ON CRATE33 CRATE14) (CRATE CRATE34) (SURFACE CRATE34)
  (AT CRATE34 DISTRIBUTOR0) (ON CRATE34 CRATE23) (CRATE CRATE35)
  (SURFACE CRATE35) (AT CRATE35 DISTRIBUTOR2) (ON CRATE35 CRATE27)
  (CRATE CRATE36) (SURFACE CRATE36) (AT CRATE36 DEPOT2)
  (ON CRATE36 CRATE24) (CRATE CRATE37) (SURFACE CRATE37)
  (AT CRATE37 DISTRIBUTOR8) (ON CRATE37 CRATE31) (CRATE CRATE38)
  (SURFACE CRATE38) (AT CRATE38 DISTRIBUTOR5) (ON CRATE38 CRATE30)
  (CRATE CRATE39) (SURFACE CRATE39) (AT CRATE39 DISTRIBUTOR5)
  (ON CRATE39 CRATE38) (CRATE CRATE40) (SURFACE CRATE40)
  (AT CRATE40 DEPOT4) (ON CRATE40 CRATE25) (CRATE CRATE41)
  (SURFACE CRATE41) (AT CRATE41 DEPOT0) (ON CRATE41 CRATE10)
  (CRATE CRATE42) (SURFACE CRATE42) (AT CRATE42 DEPOT1)
  (ON CRATE42 CRATE32) (CRATE CRATE43) (SURFACE CRATE43)
  (AT CRATE43 DEPOT5) (ON CRATE43 CRATE15) (CRATE CRATE44)
  (SURFACE CRATE44) (AT CRATE44 DEPOT5) (ON CRATE44 CRATE43)
  (CRATE CRATE45) (SURFACE CRATE45) (AT CRATE45 DEPOT2)
  (ON CRATE45 CRATE36) (CRATE CRATE46) (SURFACE CRATE46)
  (AT CRATE46 DISTRIBUTOR7) (ON CRATE46 CRATE33) (CRATE CRATE47)
  (SURFACE CRATE47) (AT CRATE47 DEPOT5) (ON CRATE47 CRATE44)
  (CRATE CRATE48) (SURFACE CRATE48) (AT CRATE48 DISTRIBUTOR8)
  (ON CRATE48 CRATE37) (CRATE CRATE49) (SURFACE CRATE49)
  (AT CRATE49 DISTRIBUTOR4) (ON CRATE49 CRATE3) (CRATE CRATE50)
  (SURFACE CRATE50) (AT CRATE50 DISTRIBUTOR0) (ON CRATE50 CRATE34)
  (CRATE CRATE51) (SURFACE CRATE51) (AT CRATE51 DISTRIBUTOR2)
  (ON CRATE51 CRATE35) (CRATE CRATE52) (SURFACE CRATE52)
  (AT CRATE52 DISTRIBUTOR1) (ON CRATE52 CRATE28) (CRATE CRATE53)
  (SURFACE CRATE53) (AT CRATE53 DEPOT5) (ON CRATE53 CRATE47)
  (CRATE CRATE54) (SURFACE CRATE54) (AT CRATE54 DEPOT0)
  (ON CRATE54 CRATE41) (CRATE CRATE55) (SURFACE CRATE55)
  (AT CRATE55 DEPOT5) (ON CRATE55 CRATE53) (CRATE CRATE56)
  (SURFACE CRATE56) (AT CRATE56 DEPOT0) (ON CRATE56 CRATE54)
  (CRATE CRATE57) (SURFACE CRATE57) (AT CRATE57 DEPOT0)
  (ON CRATE57 CRATE56) (CRATE CRATE58) (SURFACE CRATE58)
  (AT CRATE58 DISTRIBUTOR9) (ON CRATE58 CRATE17) (CRATE CRATE59)
  (SURFACE CRATE59) (AT CRATE59 DISTRIBUTOR5) (ON CRATE59 CRATE39)
  (CRATE CRATE60) (SURFACE CRATE60) (AT CRATE60 DISTRIBUTOR4)
  (ON CRATE60 CRATE49) (CRATE CRATE61) (SURFACE CRATE61)
  (AT CRATE61 DEPOT4) (ON CRATE61 CRATE40) (CRATE CRATE62)
  (SURFACE CRATE62) (AT CRATE62 DISTRIBUTOR8) (ON CRATE62 CRATE48)
  (CRATE CRATE63) (SURFACE CRATE63) (AT CRATE63 DISTRIBUTOR1)
  (ON CRATE63 CRATE52) (CRATE CRATE64) (SURFACE CRATE64)
  (AT CRATE64 DISTRIBUTOR3) (ON CRATE64 CRATE18) (CRATE CRATE65)
  (SURFACE CRATE65) (AT CRATE65 DEPOT6) (ON CRATE65 CRATE1)
  (CRATE CRATE66) (SURFACE CRATE66) (AT CRATE66 DISTRIBUTOR3)
  (ON CRATE66 CRATE64) (CRATE CRATE67) (SURFACE CRATE67)
  (AT CRATE67 DISTRIBUTOR7) (ON CRATE67 CRATE46) (CRATE CRATE68)
  (SURFACE CRATE68) (AT CRATE68 DISTRIBUTOR0) (ON CRATE68 CRATE50)
  (CRATE CRATE69) (SURFACE CRATE69) (AT CRATE69 DISTRIBUTOR3)
  (ON CRATE69 CRATE66) (CRATE CRATE70) (SURFACE CRATE70)
  (AT CRATE70 DEPOT4) (ON CRATE70 CRATE61) (CRATE CRATE71)
  (SURFACE CRATE71) (AT CRATE71 DISTRIBUTOR4) (ON CRATE71 CRATE60)
  (CRATE CRATE72) (SURFACE CRATE72) (AT CRATE72 DEPOT4)
  (ON CRATE72 CRATE70) (CRATE CRATE73) (SURFACE CRATE73)
  (AT CRATE73 DEPOT7) (ON CRATE73 PALLET7) (CRATE CRATE74)
  (SURFACE CRATE74) (AT CRATE74 DEPOT1) (ON CRATE74 CRATE42)
  (CRATE CRATE75) (SURFACE CRATE75) (AT CRATE75 DEPOT8)
  (ON CRATE75 PALLET8) (CRATE CRATE76) (SURFACE CRATE76)
  (AT CRATE76 DISTRIBUTOR9) (ON CRATE76 CRATE58) (CRATE CRATE77)
  (SURFACE CRATE77) (AT CRATE77 DEPOT8) (ON CRATE77 CRATE75)
  (CRATE CRATE78) (SURFACE CRATE78) (AT CRATE78 DEPOT4)
  (ON CRATE78 CRATE72) (CRATE CRATE79) (SURFACE CRATE79)
  (AT CRATE79 DISTRIBUTOR4) (ON CRATE79 CRATE71) (PLACE DEPOT0)
  (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3) (PLACE DEPOT4)
  (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7) (PLACE DEPOT8)
  (PLACE DEPOT9) (PLACE DISTRIBUTOR0) (PLACE DISTRIBUTOR1)
  (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3) (PLACE DISTRIBUTOR4)
  (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6) (PLACE DISTRIBUTOR7)
  (PLACE DISTRIBUTOR8) (PLACE DISTRIBUTOR9)) 
 
 ;; goal 
((ON CRATE0 CRATE46) (ON CRATE1 PALLET7) (ON CRATE2 CRATE9)
 (ON CRATE3 PALLET2) (ON CRATE4 CRATE42) (ON CRATE5 CRATE73)
 (ON CRATE6 PALLET16) (ON CRATE7 PALLET14) (ON CRATE9 CRATE15)
 (ON CRATE10 CRATE49) (ON CRATE11 CRATE40) (ON CRATE12 PALLET0)
 (ON CRATE13 CRATE67) (ON CRATE14 CRATE16) (ON CRATE15 CRATE1)
 (ON CRATE16 CRATE66) (ON CRATE17 CRATE7) (ON CRATE18 CRATE35)
 (ON CRATE19 CRATE51) (ON CRATE20 CRATE74) (ON CRATE21 CRATE4)
 (ON CRATE22 PALLET5) (ON CRATE23 CRATE24) (ON CRATE24 CRATE32)
 (ON CRATE25 CRATE23) (ON CRATE26 CRATE25) (ON CRATE27 PALLET9)
 (ON CRATE28 CRATE5) (ON CRATE30 PALLET12) (ON CRATE31 CRATE13)
 (ON CRATE32 CRATE75) (ON CRATE33 CRATE61) (ON CRATE34 CRATE47)
 (ON CRATE35 PALLET1) (ON CRATE36 CRATE34) (ON CRATE37 CRATE10)
 (ON CRATE38 CRATE58) (ON CRATE40 PALLET17) (ON CRATE42 CRATE78)
 (ON CRATE44 CRATE33) (ON CRATE45 CRATE50) (ON CRATE46 CRATE12)
 (ON CRATE47 PALLET3) (ON CRATE49 PALLET8) (ON CRATE50 CRATE38)
 (ON CRATE51 PALLET4) (ON CRATE52 CRATE11) (ON CRATE54 CRATE19)
 (ON CRATE55 CRATE6) (ON CRATE57 CRATE30) (ON CRATE58 PALLET18)
 (ON CRATE59 CRATE72) (ON CRATE60 CRATE45) (ON CRATE61 PALLET10)
 (ON CRATE62 CRATE31) (ON CRATE64 CRATE3) (ON CRATE65 PALLET13)
 (ON CRATE66 CRATE71) (ON CRATE67 CRATE20) (ON CRATE68 CRATE59)
 (ON CRATE69 CRATE55) (ON CRATE70 CRATE22) (ON CRATE71 CRATE57)
 (ON CRATE72 PALLET6) (ON CRATE73 CRATE65) (ON CRATE74 PALLET15)
 (ON CRATE75 PALLET11) (ON CRATE76 CRATE27) (ON CRATE78 PALLET19)))