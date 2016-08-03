(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_12 BLOCKS-HTN
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
  (ON B3 B1) (ON B6 B3) (ON B7 B6) (ON B11 B7) (ON B16 B11)
  (ON B24 B16) (ON B32 B24) (ON B40 B32) (ON B54 B40) (ON B60 B54)
  (ON B64 B60) (ON B72 B64) (ON B73 B72) (ON B77 B73) (ON B87 B77)
  (ON B90 B87) (CLEAR B90) (ON-TABLE B2) (ON B4 B2) (ON B8 B4)
  (ON B10 B8) (ON B12 B10) (ON B13 B12) (ON B15 B13) (ON B17 B15)
  (ON B19 B17) (ON B20 B19) (ON B33 B20) (ON B51 B33) (ON B53 B51)
  (ON B79 B53) (ON B82 B79) (ON B89 B82) (CLEAR B89) (ON-TABLE B5)
  (ON B9 B5) (ON B14 B9) (ON B18 B14) (ON B25 B18) (ON B26 B25)
  (ON B27 B26) (ON B42 B27) (ON B43 B42) (ON B50 B43) (ON B52 B50)
  (ON B59 B52) (ON B61 B59) (ON B78 B61) (ON B83 B78) (CLEAR B83)
  (ON-TABLE B21) (ON B22 B21) (ON B23 B22) (ON B28 B23) (ON B30 B28)
  (ON B31 B30) (ON B34 B31) (ON B35 B34) (ON B37 B35) (ON B38 B37)
  (ON B49 B38) (ON B55 B49) (ON B58 B55) (ON B66 B58) (ON B99 B66)
  (CLEAR B99) (ON-TABLE B29) (ON B39 B29) (ON B44 B39) (ON B48 B44)
  (ON B57 B48) (ON B70 B57) (ON B74 B70) (ON B81 B74) (ON B92 B81)
  (CLEAR B92) (ON-TABLE B36) (ON B41 B36) (ON B45 B41) (ON B46 B45)
  (ON B47 B46) (ON B63 B47) (ON B67 B63) (ON B80 B67) (ON B95 B80)
  (ON B97 B95) (CLEAR B97) (ON-TABLE B56) (ON B65 B56) (ON B68 B65)
  (ON B71 B68) (ON B75 B71) (ON B86 B75) (ON B93 B86) (ON B96 B93)
  (CLEAR B96) (ON-TABLE B62) (ON B84 B62) (ON B85 B84) (ON B91 B85)
  (ON B94 B91) (CLEAR B94) (ON-TABLE B69) (ON B76 B69) (ON B88 B76)
  (CLEAR B88) (ON-TABLE B98) (CLEAR B98) (ON-TABLE B100) (CLEAR B100))
 ((ON-TABLE B1) (ON B2 B1) (ON B6 B2) (ON B12 B6) (ON B13 B12)
  (ON B16 B13) (ON B22 B16) (ON B32 B22) (ON B62 B32) (ON B71 B62)
  (ON B82 B71) (ON B91 B82) (ON B96 B91) (CLEAR B96) (ON-TABLE B3)
  (ON B4 B3) (ON B8 B4) (ON B10 B8) (ON B20 B10) (ON B21 B20)
  (ON B30 B21) (ON B31 B30) (ON B34 B31) (ON B86 B34) (CLEAR B86)
  (ON-TABLE B5) (ON B11 B5) (ON B14 B11) (ON B17 B14) (ON B18 B17)
  (ON B23 B18) (ON B24 B23) (ON B25 B24) (ON B26 B25) (ON B41 B26)
  (ON B48 B41) (ON B53 B48) (ON B60 B53) (ON B89 B60) (ON B100 B89)
  (CLEAR B100) (ON-TABLE B7) (ON B9 B7) (ON B15 B9) (ON B37 B15)
  (ON B43 B37) (ON B51 B43) (ON B56 B51) (ON B81 B56) (CLEAR B81)
  (ON-TABLE B19) (ON B33 B19) (ON B45 B33) (ON B46 B45) (ON B50 B46)
  (ON B78 B50) (ON B79 B78) (CLEAR B79) (ON-TABLE B27) (ON B28 B27)
  (ON B35 B28) (ON B38 B35) (ON B76 B38) (CLEAR B76) (ON-TABLE B29)
  (ON B36 B29) (ON B42 B36) (ON B58 B42) (ON B70 B58) (ON B84 B70)
  (ON B85 B84) (ON B92 B85) (CLEAR B92) (ON-TABLE B39) (ON B47 B39)
  (ON B87 B47) (ON B90 B87) (CLEAR B90) (ON-TABLE B40) (ON B44 B40)
  (ON B52 B44) (ON B55 B52) (ON B65 B55) (ON B77 B65) (ON B94 B77)
  (CLEAR B94) (ON-TABLE B49) (ON B59 B49) (ON B64 B59) (ON B67 B64)
  (ON B69 B67) (ON B74 B69) (ON B99 B74) (CLEAR B99) (ON-TABLE B54)
  (ON B68 B54) (ON B88 B68) (ON B93 B88) (CLEAR B93) (ON-TABLE B57)
  (ON B83 B57) (CLEAR B83) (ON-TABLE B61) (ON B63 B61) (ON B72 B63)
  (CLEAR B72) (ON-TABLE B66) (ON B73 B66) (ON B80 B73) (CLEAR B80)
  (ON-TABLE B75) (ON B95 B75) (ON B97 B95) (ON B98 B97) (CLEAR B98)))