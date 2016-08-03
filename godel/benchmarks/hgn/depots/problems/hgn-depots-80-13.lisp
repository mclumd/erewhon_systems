(in-package :shop2)
(defproblem DEPOTPROB130 depots-domain-hgn

 ;; initial state 
 ((PALLET PALLET0) (SURFACE PALLET0) (AT PALLET0 DEPOT0)
  (CLEAR CRATE49) (PALLET PALLET1) (SURFACE PALLET1)
  (AT PALLET1 DEPOT1) (CLEAR CRATE50) (PALLET PALLET2)
  (SURFACE PALLET2) (AT PALLET2 DEPOT2) (CLEAR CRATE75)
  (PALLET PALLET3) (SURFACE PALLET3) (AT PALLET3 DEPOT3)
  (CLEAR CRATE71) (PALLET PALLET4) (SURFACE PALLET4)
  (AT PALLET4 DEPOT4) (CLEAR CRATE66) (PALLET PALLET5)
  (SURFACE PALLET5) (AT PALLET5 DEPOT5) (CLEAR CRATE40)
  (PALLET PALLET6) (SURFACE PALLET6) (AT PALLET6 DEPOT6)
  (CLEAR CRATE73) (PALLET PALLET7) (SURFACE PALLET7)
  (AT PALLET7 DEPOT7) (CLEAR CRATE62) (PALLET PALLET8)
  (SURFACE PALLET8) (AT PALLET8 DEPOT8) (CLEAR CRATE78)
  (PALLET PALLET9) (SURFACE PALLET9) (AT PALLET9 DEPOT9)
  (CLEAR CRATE67) (PALLET PALLET10) (SURFACE PALLET10)
  (AT PALLET10 DISTRIBUTOR0) (CLEAR CRATE16) (PALLET PALLET11)
  (SURFACE PALLET11) (AT PALLET11 DISTRIBUTOR1) (CLEAR CRATE65)
  (PALLET PALLET12) (SURFACE PALLET12) (AT PALLET12 DISTRIBUTOR2)
  (CLEAR CRATE79) (PALLET PALLET13) (SURFACE PALLET13)
  (AT PALLET13 DISTRIBUTOR3) (CLEAR CRATE27) (PALLET PALLET14)
  (SURFACE PALLET14) (AT PALLET14 DISTRIBUTOR4) (CLEAR CRATE30)
  (PALLET PALLET15) (SURFACE PALLET15) (AT PALLET15 DISTRIBUTOR5)
  (CLEAR CRATE77) (PALLET PALLET16) (SURFACE PALLET16)
  (AT PALLET16 DISTRIBUTOR6) (CLEAR CRATE76) (PALLET PALLET17)
  (SURFACE PALLET17) (AT PALLET17 DISTRIBUTOR7) (CLEAR CRATE60)
  (PALLET PALLET18) (SURFACE PALLET18) (AT PALLET18 DISTRIBUTOR8)
  (CLEAR CRATE63) (PALLET PALLET19) (SURFACE PALLET19)
  (AT PALLET19 DISTRIBUTOR9) (CLEAR CRATE72) (TRUCK TRUCK0)
  (AT TRUCK0 DISTRIBUTOR7) (HOIST HOIST0) (AT HOIST0 DEPOT0)
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
  (AT CRATE0 DEPOT1) (ON CRATE0 PALLET1) (CRATE CRATE1)
  (SURFACE CRATE1) (AT CRATE1 DEPOT6) (ON CRATE1 PALLET6)
  (CRATE CRATE2) (SURFACE CRATE2) (AT CRATE2 DEPOT8)
  (ON CRATE2 PALLET8) (CRATE CRATE3) (SURFACE CRATE3)
  (AT CRATE3 DEPOT4) (ON CRATE3 PALLET4) (CRATE CRATE4)
  (SURFACE CRATE4) (AT CRATE4 DEPOT9) (ON CRATE4 PALLET9)
  (CRATE CRATE5) (SURFACE CRATE5) (AT CRATE5 DEPOT4) (ON CRATE5 CRATE3)
  (CRATE CRATE6) (SURFACE CRATE6) (AT CRATE6 DEPOT3)
  (ON CRATE6 PALLET3) (CRATE CRATE7) (SURFACE CRATE7)
  (AT CRATE7 DEPOT9) (ON CRATE7 CRATE4) (CRATE CRATE8) (SURFACE CRATE8)
  (AT CRATE8 DISTRIBUTOR5) (ON CRATE8 PALLET15) (CRATE CRATE9)
  (SURFACE CRATE9) (AT CRATE9 DISTRIBUTOR6) (ON CRATE9 PALLET16)
  (CRATE CRATE10) (SURFACE CRATE10) (AT CRATE10 DEPOT3)
  (ON CRATE10 CRATE6) (CRATE CRATE11) (SURFACE CRATE11)
  (AT CRATE11 DEPOT3) (ON CRATE11 CRATE10) (CRATE CRATE12)
  (SURFACE CRATE12) (AT CRATE12 DISTRIBUTOR8) (ON CRATE12 PALLET18)
  (CRATE CRATE13) (SURFACE CRATE13) (AT CRATE13 DEPOT4)
  (ON CRATE13 CRATE5) (CRATE CRATE14) (SURFACE CRATE14)
  (AT CRATE14 DISTRIBUTOR8) (ON CRATE14 CRATE12) (CRATE CRATE15)
  (SURFACE CRATE15) (AT CRATE15 DEPOT8) (ON CRATE15 CRATE2)
  (CRATE CRATE16) (SURFACE CRATE16) (AT CRATE16 DISTRIBUTOR0)
  (ON CRATE16 PALLET10) (CRATE CRATE17) (SURFACE CRATE17)
  (AT CRATE17 DEPOT4) (ON CRATE17 CRATE13) (CRATE CRATE18)
  (SURFACE CRATE18) (AT CRATE18 DISTRIBUTOR5) (ON CRATE18 CRATE8)
  (CRATE CRATE19) (SURFACE CRATE19) (AT CRATE19 DISTRIBUTOR7)
  (ON CRATE19 PALLET17) (CRATE CRATE20) (SURFACE CRATE20)
  (AT CRATE20 DEPOT1) (ON CRATE20 CRATE0) (CRATE CRATE21)
  (SURFACE CRATE21) (AT CRATE21 DISTRIBUTOR7) (ON CRATE21 CRATE19)
  (CRATE CRATE22) (SURFACE CRATE22) (AT CRATE22 DEPOT5)
  (ON CRATE22 PALLET5) (CRATE CRATE23) (SURFACE CRATE23)
  (AT CRATE23 DISTRIBUTOR1) (ON CRATE23 PALLET11) (CRATE CRATE24)
  (SURFACE CRATE24) (AT CRATE24 DISTRIBUTOR7) (ON CRATE24 CRATE21)
  (CRATE CRATE25) (SURFACE CRATE25) (AT CRATE25 DISTRIBUTOR8)
  (ON CRATE25 CRATE14) (CRATE CRATE26) (SURFACE CRATE26)
  (AT CRATE26 DISTRIBUTOR4) (ON CRATE26 PALLET14) (CRATE CRATE27)
  (SURFACE CRATE27) (AT CRATE27 DISTRIBUTOR3) (ON CRATE27 PALLET13)
  (CRATE CRATE28) (SURFACE CRATE28) (AT CRATE28 DEPOT8)
  (ON CRATE28 CRATE15) (CRATE CRATE29) (SURFACE CRATE29)
  (AT CRATE29 DISTRIBUTOR8) (ON CRATE29 CRATE25) (CRATE CRATE30)
  (SURFACE CRATE30) (AT CRATE30 DISTRIBUTOR4) (ON CRATE30 CRATE26)
  (CRATE CRATE31) (SURFACE CRATE31) (AT CRATE31 DEPOT7)
  (ON CRATE31 PALLET7) (CRATE CRATE32) (SURFACE CRATE32)
  (AT CRATE32 DEPOT3) (ON CRATE32 CRATE11) (CRATE CRATE33)
  (SURFACE CRATE33) (AT CRATE33 DEPOT3) (ON CRATE33 CRATE32)
  (CRATE CRATE34) (SURFACE CRATE34) (AT CRATE34 DISTRIBUTOR9)
  (ON CRATE34 PALLET19) (CRATE CRATE35) (SURFACE CRATE35)
  (AT CRATE35 DEPOT3) (ON CRATE35 CRATE33) (CRATE CRATE36)
  (SURFACE CRATE36) (AT CRATE36 DEPOT2) (ON CRATE36 PALLET2)
  (CRATE CRATE37) (SURFACE CRATE37) (AT CRATE37 DEPOT6)
  (ON CRATE37 CRATE1) (CRATE CRATE38) (SURFACE CRATE38)
  (AT CRATE38 DEPOT9) (ON CRATE38 CRATE7) (CRATE CRATE39)
  (SURFACE CRATE39) (AT CRATE39 DEPOT8) (ON CRATE39 CRATE28)
  (CRATE CRATE40) (SURFACE CRATE40) (AT CRATE40 DEPOT5)
  (ON CRATE40 CRATE22) (CRATE CRATE41) (SURFACE CRATE41)
  (AT CRATE41 DEPOT7) (ON CRATE41 CRATE31) (CRATE CRATE42)
  (SURFACE CRATE42) (AT CRATE42 DEPOT8) (ON CRATE42 CRATE39)
  (CRATE CRATE43) (SURFACE CRATE43) (AT CRATE43 DISTRIBUTOR2)
  (ON CRATE43 PALLET12) (CRATE CRATE44) (SURFACE CRATE44)
  (AT CRATE44 DISTRIBUTOR8) (ON CRATE44 CRATE29) (CRATE CRATE45)
  (SURFACE CRATE45) (AT CRATE45 DEPOT3) (ON CRATE45 CRATE35)
  (CRATE CRATE46) (SURFACE CRATE46) (AT CRATE46 DISTRIBUTOR9)
  (ON CRATE46 CRATE34) (CRATE CRATE47) (SURFACE CRATE47)
  (AT CRATE47 DISTRIBUTOR7) (ON CRATE47 CRATE24) (CRATE CRATE48)
  (SURFACE CRATE48) (AT CRATE48 DEPOT2) (ON CRATE48 CRATE36)
  (CRATE CRATE49) (SURFACE CRATE49) (AT CRATE49 DEPOT0)
  (ON CRATE49 PALLET0) (CRATE CRATE50) (SURFACE CRATE50)
  (AT CRATE50 DEPOT1) (ON CRATE50 CRATE20) (CRATE CRATE51)
  (SURFACE CRATE51) (AT CRATE51 DEPOT3) (ON CRATE51 CRATE45)
  (CRATE CRATE52) (SURFACE CRATE52) (AT CRATE52 DEPOT6)
  (ON CRATE52 CRATE37) (CRATE CRATE53) (SURFACE CRATE53)
  (AT CRATE53 DISTRIBUTOR2) (ON CRATE53 CRATE43) (CRATE CRATE54)
  (SURFACE CRATE54) (AT CRATE54 DEPOT6) (ON CRATE54 CRATE52)
  (CRATE CRATE55) (SURFACE CRATE55) (AT CRATE55 DEPOT2)
  (ON CRATE55 CRATE48) (CRATE CRATE56) (SURFACE CRATE56)
  (AT CRATE56 DEPOT7) (ON CRATE56 CRATE41) (CRATE CRATE57)
  (SURFACE CRATE57) (AT CRATE57 DISTRIBUTOR2) (ON CRATE57 CRATE53)
  (CRATE CRATE58) (SURFACE CRATE58) (AT CRATE58 DISTRIBUTOR1)
  (ON CRATE58 CRATE23) (CRATE CRATE59) (SURFACE CRATE59)
  (AT CRATE59 DISTRIBUTOR2) (ON CRATE59 CRATE57) (CRATE CRATE60)
  (SURFACE CRATE60) (AT CRATE60 DISTRIBUTOR7) (ON CRATE60 CRATE47)
  (CRATE CRATE61) (SURFACE CRATE61) (AT CRATE61 DEPOT4)
  (ON CRATE61 CRATE17) (CRATE CRATE62) (SURFACE CRATE62)
  (AT CRATE62 DEPOT7) (ON CRATE62 CRATE56) (CRATE CRATE63)
  (SURFACE CRATE63) (AT CRATE63 DISTRIBUTOR8) (ON CRATE63 CRATE44)
  (CRATE CRATE64) (SURFACE CRATE64) (AT CRATE64 DEPOT3)
  (ON CRATE64 CRATE51) (CRATE CRATE65) (SURFACE CRATE65)
  (AT CRATE65 DISTRIBUTOR1) (ON CRATE65 CRATE58) (CRATE CRATE66)
  (SURFACE CRATE66) (AT CRATE66 DEPOT4) (ON CRATE66 CRATE61)
  (CRATE CRATE67) (SURFACE CRATE67) (AT CRATE67 DEPOT9)
  (ON CRATE67 CRATE38) (CRATE CRATE68) (SURFACE CRATE68)
  (AT CRATE68 DEPOT3) (ON CRATE68 CRATE64) (CRATE CRATE69)
  (SURFACE CRATE69) (AT CRATE69 DEPOT6) (ON CRATE69 CRATE54)
  (CRATE CRATE70) (SURFACE CRATE70) (AT CRATE70 DEPOT2)
  (ON CRATE70 CRATE55) (CRATE CRATE71) (SURFACE CRATE71)
  (AT CRATE71 DEPOT3) (ON CRATE71 CRATE68) (CRATE CRATE72)
  (SURFACE CRATE72) (AT CRATE72 DISTRIBUTOR9) (ON CRATE72 CRATE46)
  (CRATE CRATE73) (SURFACE CRATE73) (AT CRATE73 DEPOT6)
  (ON CRATE73 CRATE69) (CRATE CRATE74) (SURFACE CRATE74)
  (AT CRATE74 DEPOT2) (ON CRATE74 CRATE70) (CRATE CRATE75)
  (SURFACE CRATE75) (AT CRATE75 DEPOT2) (ON CRATE75 CRATE74)
  (CRATE CRATE76) (SURFACE CRATE76) (AT CRATE76 DISTRIBUTOR6)
  (ON CRATE76 CRATE9) (CRATE CRATE77) (SURFACE CRATE77)
  (AT CRATE77 DISTRIBUTOR5) (ON CRATE77 CRATE18) (CRATE CRATE78)
  (SURFACE CRATE78) (AT CRATE78 DEPOT8) (ON CRATE78 CRATE42)
  (CRATE CRATE79) (SURFACE CRATE79) (AT CRATE79 DISTRIBUTOR2)
  (ON CRATE79 CRATE59) (PLACE DEPOT0) (PLACE DEPOT1) (PLACE DEPOT2)
  (PLACE DEPOT3) (PLACE DEPOT4) (PLACE DEPOT5) (PLACE DEPOT6)
  (PLACE DEPOT7) (PLACE DEPOT8) (PLACE DEPOT9) (PLACE DISTRIBUTOR0)
  (PLACE DISTRIBUTOR1) (PLACE DISTRIBUTOR2) (PLACE DISTRIBUTOR3)
  (PLACE DISTRIBUTOR4) (PLACE DISTRIBUTOR5) (PLACE DISTRIBUTOR6)
  (PLACE DISTRIBUTOR7) (PLACE DISTRIBUTOR8) (PLACE DISTRIBUTOR9)) 
 
 ;; goal 
((ON CRATE0 CRATE75) (ON CRATE1 CRATE33) (ON CRATE2 CRATE47)
 (ON CRATE4 CRATE0) (ON CRATE5 CRATE25) (ON CRATE6 CRATE79)
 (ON CRATE7 CRATE73) (ON CRATE9 PALLET8) (ON CRATE11 PALLET2)
 (ON CRATE12 CRATE74) (ON CRATE13 CRATE42) (ON CRATE14 CRATE30)
 (ON CRATE15 PALLET16) (ON CRATE16 PALLET11) (ON CRATE18 CRATE48)
 (ON CRATE19 CRATE60) (ON CRATE20 CRATE65) (ON CRATE21 CRATE72)
 (ON CRATE22 CRATE55) (ON CRATE23 CRATE18) (ON CRATE24 PALLET0)
 (ON CRATE25 PALLET9) (ON CRATE26 CRATE36) (ON CRATE28 CRATE9)
 (ON CRATE29 CRATE77) (ON CRATE30 CRATE15) (ON CRATE31 PALLET10)
 (ON CRATE32 CRATE31) (ON CRATE33 CRATE39) (ON CRATE34 CRATE44)
 (ON CRATE35 PALLET3) (ON CRATE36 CRATE20) (ON CRATE37 CRATE1)
 (ON CRATE39 CRATE35) (ON CRATE41 CRATE29) (ON CRATE42 PALLET5)
 (ON CRATE44 PALLET6) (ON CRATE45 PALLET4) (ON CRATE46 CRATE76)
 (ON CRATE47 PALLET14) (ON CRATE48 CRATE34) (ON CRATE49 CRATE45)
 (ON CRATE50 PALLET17) (ON CRATE51 CRATE21) (ON CRATE52 CRATE78)
 (ON CRATE53 CRATE54) (ON CRATE54 CRATE50) (ON CRATE55 CRATE5)
 (ON CRATE57 CRATE13) (ON CRATE58 CRATE52) (ON CRATE59 CRATE12)
 (ON CRATE60 PALLET19) (ON CRATE61 CRATE46) (ON CRATE62 PALLET7)
 (ON CRATE63 CRATE62) (ON CRATE65 PALLET13) (ON CRATE66 PALLET12)
 (ON CRATE67 PALLET1) (ON CRATE69 CRATE57) (ON CRATE71 CRATE32)
 (ON CRATE72 CRATE63) (ON CRATE73 CRATE16) (ON CRATE74 CRATE24)
 (ON CRATE75 PALLET18) (ON CRATE76 PALLET15) (ON CRATE77 CRATE66)
 (ON CRATE78 CRATE61) (ON CRATE79 CRATE67)))