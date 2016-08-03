(IN-PACKAGE SHOP2) 
(DEFPROBLEM P90_17 BLOCKS-HTN
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
  (BLOCK B87) (BLOCK B88) (BLOCK B89) (BLOCK B90) (ON-TABLE B1)
  (ON B2 B1) (ON B4 B2) (ON B5 B4) (ON B8 B5) (ON B22 B8) (ON B23 B22)
  (ON B28 B23) (ON B29 B28) (ON B33 B29) (ON B37 B33) (ON B39 B37)
  (ON B40 B39) (ON B43 B40) (ON B48 B43) (ON B75 B48) (ON B78 B75)
  (CLEAR B78) (ON-TABLE B3) (ON B12 B3) (ON B16 B12) (ON B17 B16)
  (ON B21 B17) (ON B24 B21) (ON B26 B24) (ON B30 B26) (ON B38 B30)
  (ON B50 B38) (ON B54 B50) (ON B55 B54) (ON B81 B55) (ON B85 B81)
  (ON B86 B85) (ON B87 B86) (CLEAR B87) (ON-TABLE B6) (ON B7 B6)
  (ON B10 B7) (ON B11 B10) (ON B19 B11) (ON B35 B19) (ON B44 B35)
  (ON B69 B44) (ON B72 B69) (CLEAR B72) (ON-TABLE B9) (ON B15 B9)
  (ON B62 B15) (CLEAR B62) (ON-TABLE B13) (ON B20 B13) (ON B25 B20)
  (ON B27 B25) (ON B34 B27) (ON B45 B34) (ON B47 B45) (ON B51 B47)
  (ON B53 B51) (ON B56 B53) (ON B59 B56) (ON B64 B59) (ON B65 B64)
  (ON B70 B65) (ON B74 B70) (ON B77 B74) (ON B80 B77) (ON B88 B80)
  (ON B89 B88) (CLEAR B89) (ON-TABLE B14) (ON B18 B14) (ON B46 B18)
  (ON B49 B46) (ON B67 B49) (ON B73 B67) (CLEAR B73) (ON-TABLE B31)
  (ON B32 B31) (ON B36 B32) (ON B57 B36) (ON B60 B57) (CLEAR B60)
  (ON-TABLE B41) (ON B42 B41) (ON B63 B42) (ON B68 B63) (CLEAR B68)
  (ON-TABLE B52) (ON B58 B52) (ON B61 B58) (ON B66 B61) (ON B82 B66)
  (ON B84 B82) (ON B90 B84) (CLEAR B90) (ON-TABLE B71) (ON B76 B71)
  (CLEAR B76) (ON-TABLE B79) (ON B83 B79) (CLEAR B83))
 ((ON-TABLE B1) (ON B5 B1) (ON B10 B5) (ON B19 B10) (ON B21 B19)
  (ON B25 B21) (ON B29 B25) (ON B45 B29) (ON B50 B45) (ON B51 B50)
  (ON B62 B51) (ON B64 B62) (ON B89 B64) (CLEAR B89) (ON-TABLE B2)
  (ON B6 B2) (ON B7 B6) (ON B14 B7) (ON B17 B14) (ON B37 B17)
  (ON B38 B37) (ON B54 B38) (ON B58 B54) (ON B76 B58) (ON B77 B76)
  (ON B78 B77) (ON B79 B78) (ON B85 B79) (CLEAR B85) (ON-TABLE B3)
  (ON B4 B3) (ON B9 B4) (ON B12 B9) (ON B15 B12) (ON B24 B15)
  (ON B26 B24) (ON B34 B26) (ON B40 B34) (ON B57 B40) (ON B69 B57)
  (ON B80 B69) (ON B82 B80) (CLEAR B82) (ON-TABLE B8) (ON B11 B8)
  (ON B13 B11) (ON B16 B13) (ON B18 B16) (ON B20 B18) (ON B32 B20)
  (ON B33 B32) (ON B44 B33) (ON B68 B44) (ON B81 B68) (CLEAR B81)
  (ON-TABLE B22) (ON B27 B22) (ON B30 B27) (ON B42 B30) (ON B55 B42)
  (ON B60 B55) (ON B70 B60) (ON B74 B70) (ON B75 B74) (CLEAR B75)
  (ON-TABLE B23) (ON B28 B23) (ON B36 B28) (ON B39 B36) (ON B41 B39)
  (ON B48 B41) (ON B65 B48) (ON B84 B65) (CLEAR B84) (ON-TABLE B31)
  (ON B35 B31) (ON B63 B35) (ON B71 B63) (ON B83 B71) (ON B90 B83)
  (CLEAR B90) (ON-TABLE B43) (ON B52 B43) (ON B66 B52) (ON B67 B66)
  (ON B88 B67) (CLEAR B88) (ON-TABLE B46) (ON B49 B46) (ON B73 B49)
  (ON B87 B73) (CLEAR B87) (ON-TABLE B47) (ON B72 B47) (CLEAR B72)
  (ON-TABLE B53) (ON B56 B53) (ON B59 B56) (ON B86 B59) (CLEAR B86)
  (ON-TABLE B61) (CLEAR B61)))