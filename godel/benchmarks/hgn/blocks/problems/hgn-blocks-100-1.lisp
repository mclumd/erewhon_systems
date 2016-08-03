(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_1 BLOCKS-HTN
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
  (ON B2 B1) (ON B3 B2) (ON B14 B3) (ON B17 B14) (ON B23 B17)
  (ON B24 B23) (ON B64 B24) (ON B76 B64) (ON B91 B76) (ON B92 B91)
  (CLEAR B92) (ON-TABLE B4) (ON B5 B4) (ON B6 B5) (ON B13 B6)
  (ON B22 B13) (ON B26 B22) (ON B29 B26) (ON B30 B29) (ON B35 B30)
  (ON B44 B35) (ON B51 B44) (ON B56 B51) (ON B84 B56) (CLEAR B84)
  (ON-TABLE B7) (ON B11 B7) (ON B12 B11) (ON B34 B12) (ON B42 B34)
  (ON B65 B42) (ON B67 B65) (ON B72 B67) (ON B85 B72) (CLEAR B85)
  (ON-TABLE B8) (ON B9 B8) (ON B31 B9) (ON B36 B31) (ON B41 B36)
  (ON B61 B41) (ON B69 B61) (ON B78 B69) (ON B82 B78) (ON B87 B82)
  (ON B98 B87) (CLEAR B98) (ON-TABLE B10) (ON B27 B10) (ON B37 B27)
  (ON B48 B37) (ON B74 B48) (ON B75 B74) (CLEAR B75) (ON-TABLE B15)
  (ON B21 B15) (ON B25 B21) (ON B38 B25) (ON B47 B38) (ON B66 B47)
  (ON B88 B66) (CLEAR B88) (ON-TABLE B16) (ON B19 B16) (ON B32 B19)
  (ON B45 B32) (ON B83 B45) (CLEAR B83) (ON-TABLE B18) (ON B28 B18)
  (ON B50 B28) (ON B68 B50) (ON B73 B68) (ON B86 B73) (ON B90 B86)
  (CLEAR B90) (ON-TABLE B20) (ON B55 B20) (ON B77 B55) (ON B95 B77)
  (CLEAR B95) (ON-TABLE B33) (ON B49 B33) (ON B60 B49) (ON B80 B60)
  (CLEAR B80) (ON-TABLE B39) (ON B40 B39) (ON B57 B40) (ON B58 B57)
  (ON B62 B58) (ON B81 B62) (ON B93 B81) (ON B97 B93) (CLEAR B97)
  (ON-TABLE B43) (ON B59 B43) (ON B63 B59) (ON B79 B63) (ON B89 B79)
  (CLEAR B89) (ON-TABLE B46) (ON B54 B46) (ON B70 B54) (ON B94 B70)
  (CLEAR B94) (ON-TABLE B52) (ON B53 B52) (ON B71 B53) (ON B96 B71)
  (ON B99 B96) (CLEAR B99) (ON-TABLE B100) (CLEAR B100))
 ((ON-TABLE B1) (ON B3 B1) (ON B5 B3) (ON B13 B5) (ON B14 B13)
  (ON B16 B14) (ON B17 B16) (ON B20 B17) (ON B21 B20) (ON B24 B21)
  (ON B30 B24) (ON B56 B30) (ON B58 B56) (ON B60 B58) (ON B77 B60)
  (CLEAR B77) (ON-TABLE B2) (ON B4 B2) (ON B7 B4) (ON B18 B7)
  (ON B25 B18) (ON B36 B25) (ON B39 B36) (ON B40 B39) (ON B46 B40)
  (ON B52 B46) (ON B78 B52) (ON B88 B78) (ON B89 B88) (ON B90 B89)
  (CLEAR B90) (ON-TABLE B6) (ON B15 B6) (ON B22 B15) (ON B26 B22)
  (ON B37 B26) (ON B42 B37) (ON B51 B42) (ON B59 B51) (ON B62 B59)
  (ON B69 B62) (CLEAR B69) (ON-TABLE B8) (ON B10 B8) (ON B11 B10)
  (ON B12 B11) (ON B27 B12) (ON B32 B27) (ON B34 B32) (ON B43 B34)
  (ON B45 B43) (ON B49 B45) (ON B53 B49) (ON B71 B53) (ON B87 B71)
  (CLEAR B87) (ON-TABLE B9) (ON B19 B9) (ON B23 B19) (ON B28 B23)
  (ON B29 B28) (ON B33 B29) (ON B41 B33) (ON B55 B41) (ON B61 B55)
  (ON B76 B61) (ON B79 B76) (ON B96 B79) (ON B98 B96) (CLEAR B98)
  (ON-TABLE B31) (ON B35 B31) (ON B44 B35) (ON B67 B44) (ON B68 B67)
  (ON B80 B68) (ON B81 B80) (ON B85 B81) (ON B99 B85) (CLEAR B99)
  (ON-TABLE B38) (ON B47 B38) (ON B48 B47) (ON B63 B48) (ON B72 B63)
  (ON B75 B72) (ON B86 B75) (ON B93 B86) (CLEAR B93) (ON-TABLE B50)
  (ON B64 B50) (ON B65 B64) (ON B73 B65) (ON B82 B73) (ON B83 B82)
  (ON B91 B83) (CLEAR B91) (ON-TABLE B54) (ON B70 B54) (ON B94 B70)
  (ON B95 B94) (CLEAR B95) (ON-TABLE B57) (ON B66 B57) (ON B100 B66)
  (CLEAR B100) (ON-TABLE B74) (ON B84 B74) (ON B92 B84) (CLEAR B92)
  (ON-TABLE B97) (CLEAR B97)))