(IN-PACKAGE SHOP2) 
(DEFPROBLEM P100_4 BLOCKS-HTN
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
  (ON B5 B1) (ON B8 B5) (ON B9 B8) (ON B23 B9) (ON B24 B23)
  (ON B28 B24) (ON B33 B28) (ON B38 B33) (ON B42 B38) (ON B69 B42)
  (ON B78 B69) (ON B90 B78) (CLEAR B90) (ON-TABLE B2) (ON B3 B2)
  (ON B15 B3) (ON B30 B15) (ON B48 B30) (ON B54 B48) (ON B57 B54)
  (ON B59 B57) (ON B64 B59) (ON B65 B64) (ON B70 B65) (ON B73 B70)
  (ON B75 B73) (ON B85 B75) (CLEAR B85) (ON-TABLE B4) (ON B6 B4)
  (ON B7 B6) (ON B12 B7) (ON B17 B12) (ON B20 B17) (ON B25 B20)
  (ON B50 B25) (ON B86 B50) (ON B93 B86) (CLEAR B93) (ON-TABLE B10)
  (ON B22 B10) (ON B27 B22) (ON B36 B27) (ON B49 B36) (ON B58 B49)
  (ON B63 B58) (ON B67 B63) (ON B77 B67) (ON B91 B77) (CLEAR B91)
  (ON-TABLE B11) (ON B26 B11) (ON B37 B26) (ON B51 B37) (ON B52 B51)
  (ON B92 B52) (ON B96 B92) (ON B97 B96) (CLEAR B97) (ON-TABLE B13)
  (ON B14 B13) (ON B18 B14) (ON B19 B18) (ON B29 B19) (ON B43 B29)
  (ON B45 B43) (ON B61 B45) (ON B76 B61) (ON B79 B76) (ON B82 B79)
  (CLEAR B82) (ON-TABLE B16) (ON B21 B16) (ON B31 B21) (ON B34 B31)
  (ON B41 B34) (ON B46 B41) (ON B89 B46) (ON B98 B89) (CLEAR B98)
  (ON-TABLE B32) (ON B35 B32) (ON B60 B35) (ON B71 B60) (ON B80 B71)
  (ON B88 B80) (ON B94 B88) (ON B99 B94) (CLEAR B99) (ON-TABLE B39)
  (ON B40 B39) (ON B44 B40) (ON B47 B44) (ON B53 B47) (ON B62 B53)
  (ON B66 B62) (CLEAR B66) (ON-TABLE B55) (ON B68 B55) (ON B72 B68)
  (ON B74 B72) (ON B81 B74) (CLEAR B81) (ON-TABLE B56) (ON B83 B56)
  (ON B84 B83) (ON B87 B84) (ON B95 B87) (ON B100 B95) (CLEAR B100))
 ((ON-TABLE B1) (ON B5 B1) (ON B6 B5) (ON B8 B6) (ON B15 B8)
  (ON B34 B15) (ON B61 B34) (CLEAR B61) (ON-TABLE B2) (ON B14 B2)
  (ON B19 B14) (ON B21 B19) (ON B44 B21) (ON B58 B44) (ON B73 B58)
  (ON B74 B73) (ON B94 B74) (CLEAR B94) (ON-TABLE B3) (ON B10 B3)
  (ON B20 B10) (ON B25 B20) (ON B29 B25) (ON B31 B29) (ON B33 B31)
  (ON B57 B33) (ON B60 B57) (ON B88 B60) (ON B97 B88) (CLEAR B97)
  (ON-TABLE B4) (ON B7 B4) (ON B11 B7) (ON B23 B11) (ON B26 B23)
  (ON B28 B26) (ON B37 B28) (ON B54 B37) (ON B55 B54) (ON B67 B55)
  (ON B70 B67) (ON B96 B70) (CLEAR B96) (ON-TABLE B9) (ON B13 B9)
  (ON B16 B13) (ON B18 B16) (ON B24 B18) (ON B32 B24) (ON B35 B32)
  (ON B36 B35) (ON B52 B36) (ON B56 B52) (ON B83 B56) (CLEAR B83)
  (ON-TABLE B12) (ON B22 B12) (ON B42 B22) (ON B45 B42) (ON B79 B45)
  (ON B80 B79) (ON B91 B80) (ON B95 B91) (CLEAR B95) (ON-TABLE B17)
  (ON B27 B17) (ON B30 B27) (ON B40 B30) (ON B46 B40) (ON B51 B46)
  (ON B53 B51) (ON B59 B53) (ON B69 B59) (ON B71 B69) (ON B77 B71)
  (CLEAR B77) (ON-TABLE B38) (ON B49 B38) (ON B50 B49) (ON B62 B50)
  (ON B63 B62) (ON B100 B63) (CLEAR B100) (ON-TABLE B39) (ON B41 B39)
  (ON B43 B41) (ON B47 B43) (ON B76 B47) (ON B81 B76) (ON B84 B81)
  (CLEAR B84) (ON-TABLE B48) (ON B65 B48) (ON B68 B65) (ON B85 B68)
  (ON B87 B85) (ON B93 B87) (CLEAR B93) (ON-TABLE B64) (ON B66 B64)
  (ON B75 B66) (ON B82 B75) (ON B86 B82) (ON B89 B86) (ON B98 B89)
  (ON B99 B98) (CLEAR B99) (ON-TABLE B72) (ON B78 B72) (CLEAR B78)
  (ON-TABLE B90) (ON B92 B90) (CLEAR B92)))