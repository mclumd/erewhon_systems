(IN-PACKAGE SHOP2) 
(DEFPROBLEM P90_19 BLOCKS-HTN
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
  (ON B3 B1) (ON B15 B3) (ON B22 B15) (ON B23 B22) (ON B25 B23)
  (ON B26 B25) (ON B31 B26) (ON B43 B31) (ON B61 B43) (ON B74 B61)
  (CLEAR B74) (ON-TABLE B2) (ON B6 B2) (ON B8 B6) (ON B9 B8)
  (ON B11 B9) (ON B13 B11) (ON B17 B13) (ON B20 B17) (ON B33 B20)
  (ON B39 B33) (ON B58 B39) (ON B63 B58) (CLEAR B63) (ON-TABLE B4)
  (ON B12 B4) (ON B14 B12) (ON B16 B14) (ON B24 B16) (ON B29 B24)
  (ON B34 B29) (ON B45 B34) (ON B46 B45) (ON B48 B46) (ON B56 B48)
  (ON B59 B56) (ON B62 B59) (ON B68 B62) (ON B81 B68) (CLEAR B81)
  (ON-TABLE B5) (ON B7 B5) (ON B10 B7) (ON B30 B10) (ON B35 B30)
  (ON B52 B35) (ON B53 B52) (ON B66 B53) (ON B70 B66) (ON B77 B70)
  (ON B79 B77) (ON B87 B79) (CLEAR B87) (ON-TABLE B18) (ON B28 B18)
  (ON B32 B28) (ON B42 B32) (ON B49 B42) (CLEAR B49) (ON-TABLE B19)
  (ON B21 B19) (ON B27 B21) (ON B36 B27) (ON B37 B36) (ON B38 B37)
  (ON B50 B38) (ON B54 B50) (ON B60 B54) (CLEAR B60) (ON-TABLE B40)
  (ON B85 B40) (CLEAR B85) (ON-TABLE B41) (ON B47 B41) (ON B51 B47)
  (ON B57 B51) (ON B69 B57) (ON B80 B69) (CLEAR B80) (ON-TABLE B44)
  (ON B65 B44) (ON B75 B65) (ON B84 B75) (ON B88 B84) (CLEAR B88)
  (ON-TABLE B55) (ON B64 B55) (ON B71 B64) (ON B78 B71) (ON B82 B78)
  (ON B83 B82) (ON B86 B83) (CLEAR B86) (ON-TABLE B67) (ON B90 B67)
  (CLEAR B90) (ON-TABLE B72) (ON B73 B72) (ON B76 B73) (CLEAR B76)
  (ON-TABLE B89) (CLEAR B89))
 ((ON-TABLE B1) (ON B4 B1) (ON B5 B4) (ON B6 B5) (ON B7 B6) (ON B30 B7)
  (ON B54 B30) (ON B67 B54) (CLEAR B67) (ON-TABLE B2) (ON B3 B2)
  (ON B10 B3) (ON B11 B10) (ON B12 B11) (ON B21 B12) (ON B22 B21)
  (ON B31 B22) (ON B32 B31) (ON B34 B32) (ON B36 B34) (ON B40 B36)
  (ON B49 B40) (ON B51 B49) (ON B68 B51) (CLEAR B68) (ON-TABLE B8)
  (ON B9 B8) (ON B13 B9) (ON B15 B13) (ON B18 B15) (ON B23 B18)
  (ON B35 B23) (ON B76 B35) (ON B84 B76) (ON B85 B84) (CLEAR B85)
  (ON-TABLE B14) (ON B17 B14) (ON B53 B17) (ON B55 B53) (ON B56 B55)
  (ON B57 B56) (ON B75 B57) (ON B88 B75) (CLEAR B88) (ON-TABLE B16)
  (ON B28 B16) (ON B45 B28) (ON B48 B45) (ON B74 B48) (CLEAR B74)
  (ON-TABLE B19) (ON B24 B19) (ON B43 B24) (ON B52 B43) (ON B61 B52)
  (CLEAR B61) (ON-TABLE B20) (ON B27 B20) (ON B29 B27) (ON B33 B29)
  (ON B42 B33) (ON B62 B42) (ON B83 B62) (CLEAR B83) (ON-TABLE B25)
  (ON B26 B25) (ON B44 B26) (ON B47 B44) (ON B65 B47) (CLEAR B65)
  (ON-TABLE B37) (ON B39 B37) (ON B46 B39) (ON B60 B46) (ON B69 B60)
  (CLEAR B69) (ON-TABLE B38) (ON B41 B38) (ON B59 B41) (ON B66 B59)
  (ON B82 B66) (CLEAR B82) (ON-TABLE B50) (ON B58 B50) (ON B64 B58)
  (ON B71 B64) (CLEAR B71) (ON-TABLE B63) (ON B78 B63) (ON B79 B78)
  (CLEAR B79) (ON-TABLE B70) (ON B77 B70) (ON B80 B77) (CLEAR B80)
  (ON-TABLE B72) (ON B89 B72) (CLEAR B89) (ON-TABLE B73) (ON B81 B73)
  (ON B86 B81) (CLEAR B86) (ON-TABLE B87) (CLEAR B87) (ON-TABLE B90)
  (CLEAR B90)))