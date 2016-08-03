(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_15 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (BLOCK B41)
  (BLOCK B42) (BLOCK B43) (BLOCK B44) (BLOCK B45) (BLOCK B46)
  (BLOCK B47) (BLOCK B48) (BLOCK B49) (BLOCK B50) (BLOCK B51)
  (BLOCK B52) (BLOCK B53) (BLOCK B54) (BLOCK B55) (BLOCK B56)
  (BLOCK B57) (BLOCK B58) (BLOCK B59) (BLOCK B60) (BLOCK B61)
  (BLOCK B62) (BLOCK B63) (BLOCK B64) (BLOCK B65) (BLOCK B66)
  (BLOCK B67) (BLOCK B68) (BLOCK B69) (BLOCK B70) (BLOCK B71)
  (BLOCK B72) (BLOCK B73) (BLOCK B74) (BLOCK B75) (BLOCK B76)
  (BLOCK B77) (BLOCK B78) (BLOCK B79) (BLOCK B80) (BLOCK B81)
  (BLOCK B82) (BLOCK B83) (BLOCK B84) (BLOCK B85) (BLOCK B86)
  (BLOCK B87) (BLOCK B88) (BLOCK B89) (BLOCK B90) (BLOCK B91)
  (BLOCK B92) (BLOCK B93) (BLOCK B94) (BLOCK B95) (BLOCK B96)
  (BLOCK B97) (BLOCK B98) (BLOCK B99) (BLOCK B100) (ON-TABLE B1)
  (ON B4 B1) (ON B6 B4) (ON B8 B6) (ON B9 B8) (ON B13 B9) (ON B16 B13)
  (ON B17 B16) (ON B19 B17) (ON B32 B19) (ON B37 B32) (ON B41 B37)
  (ON B45 B41) (ON B70 B45) (ON B95 B70) (CLEAR B95) (ON-TABLE B2)
  (ON B3 B2) (ON B5 B3) (ON B11 B5) (ON B21 B11) (ON B28 B21)
  (ON B34 B28) (ON B40 B34) (ON B52 B40) (ON B54 B52) (ON B69 B54)
  (ON B73 B69) (ON B75 B73) (ON B87 B75) (ON B89 B87) (ON B90 B89)
  (ON B92 B90) (CLEAR B92) (ON-TABLE B7) (ON B10 B7) (ON B15 B10)
  (ON B23 B15) (ON B35 B23) (ON B67 B35) (ON B74 B67) (CLEAR B74)
  (ON-TABLE B12) (ON B14 B12) (ON B26 B14) (ON B39 B26) (ON B51 B39)
  (ON B60 B51) (ON B63 B60) (ON B64 B63) (ON B76 B64) (ON B83 B76)
  (CLEAR B83) (ON-TABLE B18) (ON B20 B18) (ON B24 B20) (ON B27 B24)
  (ON B46 B27) (ON B53 B46) (ON B55 B53) (ON B59 B55) (ON B62 B59)
  (ON B71 B62) (ON B93 B71) (ON B98 B93) (CLEAR B98) (ON-TABLE B22)
  (ON B25 B22) (ON B30 B25) (ON B33 B30) (ON B38 B33) (ON B42 B38)
  (ON B43 B42) (ON B44 B43) (ON B61 B44) (ON B79 B61) (CLEAR B79)
  (ON-TABLE B29) (ON B31 B29) (ON B36 B31) (ON B49 B36) (ON B57 B49)
  (ON B65 B57) (ON B66 B65) (ON B84 B66) (ON B96 B84) (CLEAR B96)
  (ON-TABLE B47) (ON B48 B47) (ON B50 B48) (ON B77 B50) (ON B97 B77)
  (CLEAR B97) (ON-TABLE B56) (ON B58 B56) (ON B94 B58) (CLEAR B94)
  (ON-TABLE B68) (ON B78 B68) (ON B81 B78) (ON B85 B81) (CLEAR B85)
  (ON-TABLE B72) (ON B80 B72) (ON B82 B80) (CLEAR B82) (ON-TABLE B86)
  (ON B100 B86) (CLEAR B100) (ON-TABLE B88) (CLEAR B88) (ON-TABLE B91)
  (CLEAR B91) (ON-TABLE B99) (CLEAR B99))
 ((ON-TABLE B1) (ON B3 B1) (ON B5 B3) (ON B20 B5) (ON B35 B20)
  (ON B40 B35) (ON B55 B40) (ON B58 B55) (CLEAR B58) (ON-TABLE B2)
  (ON B21 B2) (ON B26 B21) (ON B61 B26) (ON B65 B61) (ON B66 B65)
  (ON B67 B66) (ON B72 B67) (ON B84 B72) (ON B89 B84) (ON B100 B89)
  (CLEAR B100) (ON-TABLE B4) (ON B6 B4) (ON B8 B6) (ON B10 B8)
  (ON B14 B10) (ON B15 B14) (ON B17 B15) (ON B25 B17) (ON B33 B25)
  (ON B37 B33) (ON B38 B37) (ON B49 B38) (ON B52 B49) (ON B91 B52)
  (ON B99 B91) (CLEAR B99) (ON-TABLE B7) (ON B9 B7) (ON B11 B9)
  (ON B12 B11) (ON B22 B12) (ON B23 B22) (ON B24 B23) (ON B27 B24)
  (ON B31 B27) (ON B36 B31) (ON B39 B36) (ON B85 B39) (ON B92 B85)
  (CLEAR B92) (ON-TABLE B13) (ON B16 B13) (ON B28 B16) (ON B42 B28)
  (ON B44 B42) (ON B45 B44) (ON B50 B45) (ON B54 B50) (ON B57 B54)
  (ON B60 B57) (ON B68 B60) (ON B69 B68) (ON B75 B69) (ON B79 B75)
  (ON B82 B79) (CLEAR B82) (ON-TABLE B18) (ON B19 B18) (ON B29 B19)
  (ON B32 B29) (ON B41 B32) (ON B47 B41) (ON B53 B47) (ON B76 B53)
  (ON B77 B76) (ON B93 B77) (ON B95 B93) (CLEAR B95) (ON-TABLE B30)
  (ON B87 B30) (ON B94 B87) (ON B98 B94) (CLEAR B98) (ON-TABLE B34)
  (ON B48 B34) (ON B78 B48) (ON B80 B78) (CLEAR B80) (ON-TABLE B43)
  (ON B46 B43) (ON B62 B46) (ON B64 B62) (ON B70 B64) (ON B73 B70)
  (ON B90 B73) (CLEAR B90) (ON-TABLE B51) (ON B56 B51) (ON B71 B56)
  (ON B83 B71) (ON B86 B83) (ON B88 B86) (ON B97 B88) (CLEAR B97)
  (ON-TABLE B59) (ON B63 B59) (ON B74 B63) (ON B81 B74) (CLEAR B81)
  (ON-TABLE B96) (CLEAR B96)))