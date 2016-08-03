(IN-PACKAGE SHOP2) 
(DEFPROBLEM P90_16 BLOCKS-HTN
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
  (ON B2 B1) (ON B4 B2) (ON B5 B4) (ON B23 B5) (ON B24 B23)
  (ON B28 B24) (ON B29 B28) (ON B48 B29) (ON B52 B48) (ON B62 B52)
  (ON B66 B62) (ON B75 B66) (ON B76 B75) (ON B77 B76) (ON B86 B77)
  (CLEAR B86) (ON-TABLE B3) (ON B6 B3) (ON B10 B6) (ON B14 B10)
  (ON B17 B14) (ON B31 B17) (ON B45 B31) (ON B55 B45) (ON B60 B55)
  (CLEAR B60) (ON-TABLE B7) (ON B8 B7) (ON B9 B8) (ON B11 B9)
  (ON B12 B11) (ON B15 B12) (ON B16 B15) (ON B20 B16) (ON B21 B20)
  (ON B25 B21) (ON B40 B25) (ON B81 B40) (CLEAR B81) (ON-TABLE B13)
  (ON B27 B13) (ON B38 B27) (ON B43 B38) (ON B51 B43) (ON B53 B51)
  (ON B59 B53) (ON B64 B59) (ON B70 B64) (ON B79 B70) (CLEAR B79)
  (ON-TABLE B18) (ON B19 B18) (ON B61 B19) (ON B63 B61) (ON B68 B63)
  (ON B73 B68) (ON B78 B73) (ON B82 B78) (ON B85 B82) (ON B88 B85)
  (ON B90 B88) (CLEAR B90) (ON-TABLE B22) (ON B33 B22) (ON B35 B33)
  (ON B67 B35) (ON B84 B67) (ON B89 B84) (CLEAR B89) (ON-TABLE B26)
  (ON B30 B26) (ON B34 B30) (ON B37 B34) (ON B39 B37) (ON B41 B39)
  (ON B42 B41) (ON B56 B42) (ON B71 B56) (ON B87 B71) (CLEAR B87)
  (ON-TABLE B32) (ON B36 B32) (ON B74 B36) (ON B80 B74) (CLEAR B80)
  (ON-TABLE B44) (ON B47 B44) (ON B49 B47) (ON B50 B49) (ON B83 B50)
  (CLEAR B83) (ON-TABLE B46) (ON B54 B46) (ON B57 B54) (ON B58 B57)
  (ON B65 B58) (ON B69 B65) (CLEAR B69) (ON-TABLE B72) (CLEAR B72))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B8 B3) (ON B14 B8)
  (ON B16 B14) (ON B18 B16) (ON B19 B18) (ON B42 B19) (ON B47 B42)
  (ON B51 B47) (ON B55 B51) (ON B80 B55) (CLEAR B80) (ON-TABLE B4)
  (ON B5 B4) (ON B6 B5) (ON B7 B6) (ON B12 B7) (ON B21 B12)
  (ON B26 B21) (ON B28 B26) (ON B38 B28) (ON B44 B38) (ON B50 B44)
  (ON B62 B50) (ON B64 B62) (ON B79 B64) (ON B83 B79) (ON B85 B83)
  (CLEAR B85) (ON-TABLE B9) (ON B10 B9) (ON B13 B10) (ON B17 B13)
  (ON B31 B17) (ON B32 B31) (ON B33 B32) (ON B45 B33) (ON B77 B45)
  (ON B84 B77) (CLEAR B84) (ON-TABLE B11) (ON B22 B11) (ON B23 B22)
  (ON B25 B23) (ON B29 B25) (ON B30 B29) (ON B36 B30) (ON B49 B36)
  (ON B61 B49) (ON B70 B61) (ON B73 B70) (ON B74 B73) (ON B86 B74)
  (CLEAR B86) (ON-TABLE B15) (ON B20 B15) (ON B24 B20) (ON B34 B24)
  (ON B37 B34) (ON B56 B37) (ON B63 B56) (ON B65 B63) (ON B69 B65)
  (ON B72 B69) (ON B81 B72) (CLEAR B81) (ON-TABLE B27) (ON B35 B27)
  (ON B40 B35) (ON B43 B40) (ON B48 B43) (ON B52 B48) (ON B53 B52)
  (ON B54 B53) (ON B71 B54) (ON B89 B71) (CLEAR B89) (ON-TABLE B39)
  (ON B41 B39) (ON B46 B41) (ON B59 B46) (ON B67 B59) (ON B75 B67)
  (ON B76 B75) (CLEAR B76) (ON-TABLE B57) (ON B58 B57) (ON B60 B58)
  (ON B87 B60) (CLEAR B87) (ON-TABLE B66) (ON B68 B66) (CLEAR B68)
  (ON-TABLE B78) (ON B88 B78) (CLEAR B88) (ON-TABLE B82) (ON B90 B82)
  (CLEAR B90)))