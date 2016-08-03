(in-package :shop2)
(defproblem DEPOTPROB110 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE71) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE70) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE52)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE64) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE66) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE50)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE78) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE41) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE68)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DEPOT9)
  (CLEAR CRATE79) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR0) (CLEAR CRATE73) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR1) (CLEAR CRATE46)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR2)
  (CLEAR CRATE69) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR3) (CLEAR CRATE33) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR4) (CLEAR CRATE72)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR5)
  (CLEAR CRATE34) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR6) (CLEAR CRATE76) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR7) (CLEAR CRATE55)
  (PALLET PALLET18) (SURFACE PALLET18) (AT PALLET18 DISTRIBUTOR8)
  (CLEAR CRATE77) (PALLET PALLET19) (SURFACE PALLET19)
  (AT PALLET19 DISTRIBUTOR9) (CLEAR CRATE63) (TRUCK TRUCK0)
  (AT TRUCK0 DEPOT5) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DEPOT7) (ON CRATE0 PALLET7) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT5) (ON CRATE1 PALLET5)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT2)
  (ON CRATE2 PALLET2) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT0) (ON CRATE3 PALLET0) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DISTRIBUTOR7) (ON CRATE4 PALLET17)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DISTRIBUTOR0)
  (ON CRATE5 PALLET10) (CRATE CRATE6) (SURFACE CRATE6)
  (AT CRATE6 DEPOT4) (ON CRATE6 PALLET4) (CRATE CRATE7)
  (SURFACE CRATE7) (AT CRATE7 DEPOT3) (ON CRATE7 PALLET3)
  (CRATE CRATE8) (SURFACE CRATE8) (AT CRATE8 DISTRIBUTOR1)
  (ON CRATE8 PALLET11) (CRATE CRATE9) (SURFACE CRATE9)
  (AT CRATE9 DEPOT6) (ON CRATE9 PALLET6) (CRATE CRATE10)
  (SURFACE CRATE10) (AT CRATE10 DEPOT6) (ON CRATE10 CRATE9)
  (CRATE CRATE11) (SURFACE CRATE11) (AT CRATE11 DISTRIBUTOR5)
  (ON CRATE11 PALLET15) (CRATE CRATE12) (SURFACE CRATE12)
  (AT CRATE12 DISTRIBUTOR8) (ON CRATE12 PALLET18) (CRATE CRATE13)
  (SURFACE CRATE13) (AT CRATE13 DEPOT7) (ON CRATE13 CRATE0)
  (CRATE CRATE14) (SURFACE CRATE14) (AT CRATE14 DEPOT1)
  (ON CRATE14 PALLET1) (CRATE CRATE15) (SURFACE CRATE15)
  (AT CRATE15 DISTRIBUTOR7) (ON CRATE15 CRATE4) (CRATE CRATE16)
  (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR1) (ON CRATE16 CRATE8)
  (CRATE CRATE17) (SURFACE CRATE17) (AT CRATE17 DEPOT6)
  (ON CRATE17 CRATE10) (CRATE CRATE18) (SURFACE CRATE18)
  (AT CRATE18 DISTRIBUTOR2) (ON CRATE18 PALLET12) (CRATE CRATE19)
  (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR5) (ON CRATE19 CRATE11)
  (CRATE CRATE20) (SURFACE CRATE20) (AT CRATE20 DISTRIBUTOR5)
  (ON CRATE20 CRATE19) (CRATE CRATE21) (SURFACE CRATE21)
  (AT CRATE21 DEPOT4) (ON CRATE21 CRATE6) (CRATE CRATE22)
  (SURFACE CRATE22) (AT CRATE22 DEPOT9) (ON CRATE22 PALLET9)
  (CRATE CRATE23) (SURFACE CRATE23) (AT CRATE23 DISTRIBUTOR9)
  (ON CRATE23 PALLET19) (CRATE CRATE24) (SURFACE CRATE24)
  (AT CRATE24 DEPOT9) (ON CRATE24 CRATE22) (CRATE CRATE25)
  (SURFACE CRATE25) (AT CRATE25 DEPOT5) (ON CRATE25 CRATE1)
  (CRATE CRATE26) (SURFACE CRATE26) (AT CRATE26 DISTRIBUTOR2)
  (ON CRATE26 CRATE18) (CRATE CRATE27) (SURFACE CRATE27)
  (AT CRATE27 DISTRIBUTOR0) (ON CRATE27 CRATE5) (CRATE CRATE28)
  (SURFACE CRATE28) (AT CRATE28 DISTRIBUTOR2) (ON CRATE28 CRATE26)
  (CRATE CRATE29) (SURFACE CRATE29) (AT CRATE29 DEPOT6)
  (ON CRATE29 CRATE17) (CRATE CRATE30) (SURFACE CRATE30)
  (AT CRATE30 DEPOT8) (ON CRATE30 PALLET8) (CRATE CRATE31)
  (SURFACE CRATE31) (AT CRATE31 DEPOT2) (ON CRATE31 CRATE2)
  (CRATE CRATE32) (SURFACE CRATE32) (AT CRATE32 DEPOT7)
  (ON CRATE32 CRATE13) (CRATE CRATE33) (SURFACE CRATE33)
  (AT CRATE33 DISTRIBUTOR3) (ON CRATE33 PALLET13) (CRATE CRATE34)
  (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR5) (ON CRATE34 CRATE20)
  (CRATE CRATE35) (SURFACE CRATE35) (AT CRATE35 DEPOT9)
  (ON CRATE35 CRATE24) (CRATE CRATE36) (SURFACE CRATE36)
  (AT CRATE36 DISTRIBUTOR4) (ON CRATE36 PALLET14) (CRATE CRATE37)
  (SURFACE CRATE37) (AT CRATE37 DISTRIBUTOR0) (ON CRATE37 CRATE27)
  (CRATE CRATE38) (SURFACE CRATE38) (AT CRATE38 DEPOT2)
  (ON CRATE38 CRATE31) (CRATE CRATE39) (SURFACE CRATE39)
  (AT CRATE39 DEPOT4) (ON CRATE39 CRATE21) (CRATE CRATE40)
  (SURFACE CRATE40) (AT CRATE40 DISTRIBUTOR6) (ON CRATE40 PALLET16)
  (CRATE CRATE41) (SURFACE CRATE41) (AT CRATE41 DEPOT7)
  (ON CRATE41 CRATE32) (CRATE CRATE42) (SURFACE CRATE42)
  (AT CRATE42 DISTRIBUTOR1) (ON CRATE42 CRATE16) (CRATE CRATE43)
  (SURFACE CRATE43) (AT CRATE43 DEPOT0) (ON CRATE43 CRATE3)
  (CRATE CRATE44) (SURFACE CRATE44) (AT CRATE44 DISTRIBUTOR6)
  (ON CRATE44 CRATE40) (CRATE CRATE45) (SURFACE CRATE45)
  (AT CRATE45 DISTRIBUTOR7) (ON CRATE45 CRATE15) (CRATE CRATE46)
  (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR1) (ON CRATE46 CRATE42)
  (CRATE CRATE47) (SURFACE CRATE47) (AT CRATE47 DEPOT3)
  (ON CRATE47 CRATE7) (CRATE CRATE48) (SURFACE CRATE48)
  (AT CRATE48 DEPOT9) (ON CRATE48 CRATE35) (CRATE CRATE49)
  (SURFACE CRATE49) (AT CRATE49 DISTRIBUTOR7) (ON CRATE49 CRATE45)
  (CRATE CRATE50) (SURFACE CRATE50) (AT CRATE50 DEPOT5)
  (ON CRATE50 CRATE25) (CRATE CRATE51) (SURFACE CRATE51)
  (AT CRATE51 DISTRIBUTOR6) (ON CRATE51 CRATE44) (CRATE CRATE52)
  (SURFACE CRATE52) (AT CRATE52 DEPOT2) (ON CRATE52 CRATE38)
  (CRATE CRATE53) (SURFACE CRATE53) (AT CRATE53 DEPOT3)
  (ON CRATE53 CRATE47) (CRATE CRATE54) (SURFACE CRATE54)
  (AT CRATE54 DISTRIBUTOR7) (ON CRATE54 CRATE49) (CRATE CRATE55)
  (SURFACE CRATE55) (AT CRATE55 DISTRIBUTOR7) (ON CRATE55 CRATE54)
  (CRATE CRATE56) (SURFACE CRATE56) (AT CRATE56 DISTRIBUTOR8)
  (ON CRATE56 CRATE12) (CRATE CRATE57) (SURFACE CRATE57)
  (AT CRATE57 DEPOT3) (ON CRATE57 CRATE53) (CRATE CRATE58)
  (SURFACE CRATE58) (AT CRATE58 DEPOT3) (ON CRATE58 CRATE57)
  (CRATE CRATE59) (SURFACE CRATE59) (AT CRATE59 DISTRIBUTOR4)
  (ON CRATE59 CRATE36) (CRATE CRATE60) (SURFACE CRATE60)
  (AT CRATE60 DISTRIBUTOR0) (ON CRATE60 CRATE37) (CRATE CRATE61)
  (SURFACE CRATE61) (AT CRATE61 DEPOT3) (ON CRATE61 CRATE58)
  (CRATE CRATE62) (SURFACE CRATE62) (AT CRATE62 DISTRIBUTOR2)
  (ON CRATE62 CRATE28) (CRATE CRATE63) (SURFACE CRATE63)
  (AT CRATE63 DISTRIBUTOR9) (ON CRATE63 CRATE23) (CRATE CRATE64)
  (SURFACE CRATE64) (AT CRATE64 DEPOT3) (ON CRATE64 CRATE61)
  (CRATE CRATE65) (SURFACE CRATE65) (AT CRATE65 DEPOT6)
  (ON CRATE65 CRATE29) (CRATE CRATE66) (SURFACE CRATE66)
  (AT CRATE66 DEPOT4) (ON CRATE66 CRATE39) (CRATE CRATE67)
  (SURFACE CRATE67) (AT CRATE67 DEPOT8) (ON CRATE67 CRATE30)
  (CRATE CRATE68) (SURFACE CRATE68) (AT CRATE68 DEPOT8)
  (ON CRATE68 CRATE67) (CRATE CRATE69) (SURFACE CRATE69)
  (AT CRATE69 DISTRIBUTOR2) (ON CRATE69 CRATE62) (CRATE CRATE70)
  (SURFACE CRATE70) (AT CRATE70 DEPOT1) (ON CRATE70 CRATE14)
  (CRATE CRATE71) (SURFACE CRATE71) (AT CRATE71 DEPOT0)
  (ON CRATE71 CRATE43) (CRATE CRATE72) (SURFACE CRATE72)
  (AT CRATE72 DISTRIBUTOR4) (ON CRATE72 CRATE59) (CRATE CRATE73)
  (SURFACE CRATE73) (AT CRATE73 DISTRIBUTOR0) (ON CRATE73 CRATE60)
  (CRATE CRATE74) (SURFACE CRATE74) (AT CRATE74 DEPOT6)
  (ON CRATE74 CRATE65) (CRATE CRATE75) (SURFACE CRATE75)
  (AT CRATE75 DISTRIBUTOR6) (ON CRATE75 CRATE51) (CRATE CRATE76)
  (SURFACE CRATE76) (AT CRATE76 DISTRIBUTOR6) (ON CRATE76 CRATE75)
  (CRATE CRATE77) (SURFACE CRATE77) (AT CRATE77 DISTRIBUTOR8)
  (ON CRATE77 CRATE56) (CRATE CRATE78) (SURFACE CRATE78)
  (AT CRATE78 DEPOT6) (ON CRATE78 CRATE74) (CRATE CRATE79)
  (SURFACE CRATE79) (AT CRATE79 DEPOT9) (ON CRATE79 CRATE48)
  (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2) (PLACE DEPOT3)
  (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6) (PLACE DEPOT7)
  (PLACE DEPOT8) (PLACE DEPOT9) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)
  (PLACE DISTRIBUTOR7) (PLACE DISTRIBUTOR8) (PLACE DISTRIBUTOR9)) 
 
 ;; goal 
((ON CRATE0 PALLET17) (ON CRATE1 CRATE22) (ON CRATE2 CRATE56)
 (ON CRATE4 CRATE58) (ON CRATE5 CRATE14) (ON CRATE6 PALLET8)
 (ON CRATE7 CRATE25) (ON CRATE8 CRATE49) (ON CRATE9 PALLET12)
 (ON CRATE10 CRATE0) (ON CRATE11 CRATE44) (ON CRATE12 PALLET5)
 (ON CRATE13 CRATE68) (ON CRATE14 CRATE13) (ON CRATE15 CRATE10)
 (ON CRATE16 PALLET16) (ON CRATE17 CRATE15) (ON CRATE18 CRATE6)
 (ON CRATE19 PALLET2) (ON CRATE20 CRATE55) (ON CRATE21 PALLET11)
 (ON CRATE22 CRATE46) (ON CRATE24 CRATE38) (ON CRATE25 PALLET10)
 (ON CRATE26 CRATE61) (ON CRATE27 PALLET0) (ON CRATE28 CRATE51)
 (ON CRATE30 PALLET18) (ON CRATE31 CRATE28) (ON CRATE32 CRATE21)
 (ON CRATE33 PALLET6) (ON CRATE35 CRATE4) (ON CRATE36 CRATE40)
 (ON CRATE38 CRATE42) (ON CRATE39 CRATE11) (ON CRATE40 CRATE41)
 (ON CRATE41 CRATE63) (ON CRATE42 PALLET15) (ON CRATE43 CRATE5)
 (ON CRATE44 PALLET14) (ON CRATE45 CRATE79) (ON CRATE46 PALLET3)
 (ON CRATE47 CRATE27) (ON CRATE48 CRATE1) (ON CRATE49 CRATE52)
 (ON CRATE51 CRATE16) (ON CRATE52 CRATE33) (ON CRATE53 CRATE19)
 (ON CRATE54 PALLET1) (ON CRATE55 PALLET4) (ON CRATE56 CRATE76)
 (ON CRATE58 PALLET7) (ON CRATE60 CRATE18) (ON CRATE61 CRATE75)
 (ON CRATE62 CRATE30) (ON CRATE63 PALLET19) (ON CRATE64 PALLET9)
 (ON CRATE66 CRATE69) (ON CRATE67 CRATE54) (ON CRATE68 CRATE7)
 (ON CRATE69 CRATE53) (ON CRATE71 CRATE64) (ON CRATE72 CRATE45)
 (ON CRATE75 CRATE48) (ON CRATE76 PALLET13) (ON CRATE77 CRATE47)
 (ON CRATE78 CRATE12) (ON CRATE79 CRATE67)))