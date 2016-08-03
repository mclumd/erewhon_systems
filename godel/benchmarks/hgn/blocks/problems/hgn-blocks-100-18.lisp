(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_18 BLOCKS-HTN
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
  (ON B4 B1) (ON B23 B4) (ON B28 B23) (ON B50 B28) (ON B51 B50)
  (ON B55 B51) (ON B58 B55) (ON B63 B58) (ON B98 B63) (CLEAR B98)
  (ON-TABLE B2) (ON B6 B2) (ON B8 B6) (ON B12 B8) (ON B34 B12)
  (ON B46 B34) (ON B47 B46) (ON B72 B47) (ON B82 B72) (ON B85 B82)
  (ON B90 B85) (ON B97 B90) (CLEAR B97) (ON-TABLE B3) (ON B14 B3)
  (ON B15 B14) (ON B20 B15) (ON B35 B20) (ON B52 B35) (ON B92 B52)
  (CLEAR B92) (ON-TABLE B5) (ON B31 B5) (ON B37 B31) (ON B59 B37)
  (ON B78 B59) (CLEAR B78) (ON-TABLE B7) (ON B24 B7) (ON B26 B24)
  (ON B32 B26) (ON B33 B32) (ON B44 B33) (ON B67 B44) (ON B70 B67)
  (ON B81 B70) (ON B100 B81) (CLEAR B100) (ON-TABLE B9) (ON B25 B9)
  (ON B40 B25) (CLEAR B40) (ON-TABLE B10) (ON B11 B10) (ON B13 B11)
  (ON B16 B13) (ON B48 B16) (ON B60 B48) (ON B74 B60) (ON B84 B74)
  (ON B86 B84) (CLEAR B86) (ON-TABLE B17) (ON B27 B17) (ON B30 B27)
  (ON B36 B30) (ON B42 B36) (ON B62 B42) (ON B69 B62) (ON B94 B69)
  (CLEAR B94) (ON-TABLE B18) (ON B21 B18) (ON B22 B21) (ON B39 B22)
  (ON B79 B39) (ON B80 B79) (CLEAR B80) (ON-TABLE B19) (ON B29 B19)
  (ON B88 B29) (CLEAR B88) (ON-TABLE B38) (ON B41 B38) (ON B45 B41)
  (ON B65 B45) (ON B87 B65) (CLEAR B87) (ON-TABLE B43) (ON B56 B43)
  (ON B57 B56) (ON B64 B57) (ON B77 B64) (ON B83 B77) (CLEAR B83)
  (ON-TABLE B49) (ON B54 B49) (ON B66 B54) (CLEAR B66) (ON-TABLE B53)
  (ON B76 B53) (ON B93 B76) (CLEAR B93) (ON-TABLE B61) (CLEAR B61)
  (ON-TABLE B68) (ON B73 B68) (ON B95 B73) (CLEAR B95) (ON-TABLE B71)
  (ON B96 B71) (CLEAR B96) (ON-TABLE B75) (ON B99 B75) (CLEAR B99)
  (ON-TABLE B89) (ON B91 B89) (CLEAR B91))
 ((ON-TABLE B1) (ON B3 B1) (ON B11 B3) (ON B12 B11) (ON B19 B12)
  (ON B22 B19) (ON B30 B22) (ON B33 B30) (ON B42 B33) (ON B50 B42)
  (ON B60 B50) (ON B65 B60) (ON B66 B65) (ON B69 B66) (ON B76 B69)
  (ON B87 B76) (ON B99 B87) (CLEAR B99) (ON-TABLE B2) (ON B4 B2)
  (ON B13 B4) (ON B21 B13) (ON B26 B21) (ON B78 B26) (ON B83 B78)
  (ON B92 B83) (CLEAR B92) (ON-TABLE B5) (ON B7 B5) (ON B8 B7)
  (ON B16 B8) (ON B17 B16) (ON B27 B17) (ON B34 B27) (ON B41 B34)
  (ON B44 B41) (ON B54 B44) (ON B55 B54) (ON B61 B55) (ON B70 B61)
  (ON B75 B70) (CLEAR B75) (ON-TABLE B6) (ON B9 B6) (ON B23 B9)
  (ON B25 B23) (ON B35 B25) (ON B52 B35) (ON B58 B52) (ON B89 B58)
  (CLEAR B89) (ON-TABLE B10) (ON B14 B10) (ON B20 B14) (ON B37 B20)
  (ON B43 B37) (ON B53 B43) (ON B85 B53) (ON B94 B85) (CLEAR B94)
  (ON-TABLE B15) (ON B18 B15) (ON B28 B18) (ON B36 B28) (ON B45 B36)
  (ON B48 B45) (ON B57 B48) (ON B59 B57) (ON B68 B59) (ON B71 B68)
  (ON B77 B71) (ON B80 B77) (ON B84 B80) (ON B93 B84) (ON B97 B93)
  (ON B98 B97) (ON B100 B98) (CLEAR B100) (ON-TABLE B24) (ON B29 B24)
  (ON B32 B29) (ON B51 B32) (ON B56 B51) (ON B74 B56) (ON B86 B74)
  (ON B96 B86) (CLEAR B96) (ON-TABLE B31) (ON B40 B31) (ON B46 B40)
  (ON B47 B46) (ON B64 B47) (ON B72 B64) (ON B73 B72) (ON B81 B73)
  (ON B82 B81) (ON B91 B82) (ON B95 B91) (CLEAR B95) (ON-TABLE B38)
  (ON B39 B38) (ON B49 B39) (ON B67 B49) (CLEAR B67) (ON-TABLE B62)
  (ON B63 B62) (ON B79 B63) (ON B88 B79) (ON B90 B88) (CLEAR B90)))