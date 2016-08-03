(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_5 BLOCKS-HTN
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
  (ON B3 B1) (ON B5 B3) (ON B15 B5) (ON B25 B15) (ON B46 B25)
  (ON B67 B46) (ON B81 B67) (ON B83 B81) (ON B88 B83) (ON B100 B88)
  (CLEAR B100) (ON-TABLE B2) (ON B12 B2) (ON B13 B12) (ON B38 B13)
  (ON B52 B38) (ON B57 B52) (ON B68 B57) (ON B79 B68) (ON B85 B79)
  (ON B90 B85) (ON B93 B90) (ON B97 B93) (CLEAR B97) (ON-TABLE B4)
  (ON B8 B4) (ON B11 B8) (ON B22 B11) (ON B35 B22) (ON B40 B35)
  (ON B43 B40) (ON B51 B43) (ON B54 B51) (CLEAR B54) (ON-TABLE B6)
  (ON B7 B6) (ON B14 B7) (ON B17 B14) (ON B23 B17) (ON B31 B23)
  (ON B36 B31) (ON B53 B36) (ON B56 B53) (ON B80 B56) (ON B84 B80)
  (ON B86 B84) (ON B91 B86) (CLEAR B91) (ON-TABLE B9) (ON B10 B9)
  (ON B21 B10) (ON B33 B21) (ON B45 B33) (ON B49 B45) (ON B60 B49)
  (ON B61 B60) (CLEAR B61) (ON-TABLE B16) (ON B27 B16) (ON B50 B27)
  (ON B66 B50) (ON B72 B66) (ON B73 B72) (ON B87 B73) (CLEAR B87)
  (ON-TABLE B18) (ON B19 B18) (ON B30 B19) (ON B39 B30) (ON B41 B39)
  (ON B44 B41) (ON B69 B44) (ON B94 B69) (ON B99 B94) (CLEAR B99)
  (ON-TABLE B20) (ON B26 B20) (ON B34 B26) (ON B47 B34) (ON B58 B47)
  (ON B64 B58) (ON B65 B64) (ON B70 B65) (ON B78 B70) (CLEAR B78)
  (ON-TABLE B24) (ON B32 B24) (ON B42 B32) (ON B62 B42) (ON B63 B62)
  (ON B74 B63) (ON B89 B74) (CLEAR B89) (ON-TABLE B28) (ON B29 B28)
  (ON B37 B29) (ON B48 B37) (ON B71 B48) (ON B82 B71) (CLEAR B82)
  (ON-TABLE B55) (ON B59 B55) (ON B77 B59) (CLEAR B77) (ON-TABLE B75)
  (ON B76 B75) (ON B95 B76) (ON B96 B95) (ON B98 B96) (CLEAR B98)
  (ON-TABLE B92) (CLEAR B92))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B6 B3) (ON B7 B6) (ON B9 B7)
  (ON B11 B9) (ON B12 B11) (ON B14 B12) (ON B15 B14) (ON B18 B15)
  (ON B19 B18) (ON B27 B19) (ON B32 B27) (ON B33 B32) (ON B36 B33)
  (CLEAR B36) (ON-TABLE B4) (ON B5 B4) (ON B16 B5) (ON B17 B16)
  (ON B22 B17) (ON B25 B22) (ON B40 B25) (ON B59 B40) (CLEAR B59)
  (ON-TABLE B8) (ON B13 B8) (ON B20 B13) (ON B21 B20) (ON B28 B21)
  (ON B38 B28) (ON B39 B38) (ON B77 B39) (ON B79 B77) (ON B82 B79)
  (ON B90 B82) (ON B94 B90) (CLEAR B94) (ON-TABLE B10) (ON B30 B10)
  (ON B35 B30) (ON B44 B35) (ON B48 B44) (ON B56 B48) (ON B58 B56)
  (ON B65 B58) (ON B66 B65) (ON B100 B66) (CLEAR B100) (ON-TABLE B23)
  (ON B49 B23) (ON B71 B49) (ON B87 B71) (CLEAR B87) (ON-TABLE B24)
  (ON B42 B24) (ON B45 B42) (ON B52 B45) (ON B54 B52) (ON B91 B54)
  (CLEAR B91) (ON-TABLE B26) (ON B29 B26) (ON B34 B29) (ON B67 B34)
  (ON B72 B67) (ON B75 B72) (ON B83 B75) (CLEAR B83) (ON-TABLE B31)
  (ON B57 B31) (ON B84 B57) (CLEAR B84) (ON-TABLE B37) (ON B43 B37)
  (ON B60 B43) (CLEAR B60) (ON-TABLE B41) (ON B95 B41) (ON B96 B95)
  (CLEAR B96) (ON-TABLE B46) (ON B51 B46) (ON B53 B51) (ON B62 B53)
  (ON B63 B62) (CLEAR B63) (ON-TABLE B47) (ON B61 B47) (ON B70 B61)
  (ON B73 B70) (ON B93 B73) (CLEAR B93) (ON-TABLE B50) (ON B76 B50)
  (ON B92 B76) (CLEAR B92) (ON-TABLE B55) (ON B81 B55) (ON B97 B81)
  (CLEAR B97) (ON-TABLE B64) (ON B74 B64) (ON B80 B74) (ON B85 B80)
  (ON B86 B85) (ON B98 B86) (CLEAR B98) (ON-TABLE B68) (ON B69 B68)
  (ON B78 B69) (ON B99 B78) (CLEAR B99) (ON-TABLE B88) (ON B89 B88)
  (CLEAR B89)))