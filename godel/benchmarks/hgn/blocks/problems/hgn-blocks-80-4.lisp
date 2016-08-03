(IN-PACKAGE SHOP2) 
(DEFPROBLEM P80_4 BLOCKS-HTN
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
  (BLOCK B77) (BLOCK B78) (BLOCK B79) (BLOCK B80) (ON-TABLE B1)
  (ON B9 B1) (ON B11 B9) (ON B12 B11) (ON B19 B12) (ON B23 B19)
  (ON B24 B23) (ON B49 B24) (ON B60 B49) (ON B64 B60) (ON B69 B64)
  (ON B72 B69) (ON B74 B72) (CLEAR B74) (ON-TABLE B2) (ON B13 B2)
  (ON B21 B13) (ON B27 B21) (ON B30 B27) (ON B34 B30) (ON B38 B34)
  (ON B58 B38) (ON B70 B58) (ON B80 B70) (CLEAR B80) (ON-TABLE B3)
  (ON B4 B3) (ON B6 B4) (ON B8 B6) (ON B20 B8) (ON B22 B20)
  (ON B25 B22) (ON B35 B25) (ON B37 B35) (ON B45 B37) (ON B56 B45)
  (ON B65 B56) (ON B76 B65) (ON B78 B76) (CLEAR B78) (ON-TABLE B5)
  (ON B15 B5) (ON B16 B15) (ON B17 B16) (ON B31 B17) (ON B32 B31)
  (ON B48 B32) (ON B51 B48) (ON B75 B51) (ON B79 B75) (CLEAR B79)
  (ON-TABLE B7) (ON B10 B7) (ON B14 B10) (ON B18 B14) (ON B28 B18)
  (ON B42 B28) (ON B71 B42) (CLEAR B71) (ON-TABLE B26) (ON B33 B26)
  (ON B46 B33) (ON B52 B46) (ON B66 B52) (ON B67 B66) (CLEAR B67)
  (ON-TABLE B29) (ON B36 B29) (ON B44 B36) (ON B47 B44) (ON B68 B47)
  (ON B77 B68) (CLEAR B77) (ON-TABLE B39) (ON B40 B39) (ON B41 B40)
  (ON B43 B41) (ON B61 B43) (ON B62 B61) (CLEAR B62) (ON-TABLE B50)
  (ON B53 B50) (ON B54 B53) (ON B55 B54) (ON B59 B55) (ON B63 B59)
  (ON B73 B63) (CLEAR B73) (ON-TABLE B57) (CLEAR B57))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B14 B5)
  (ON B52 B14) (ON B54 B52) (ON B68 B54) (ON B74 B68) (ON B76 B74)
  (CLEAR B76) (ON-TABLE B6) (ON B7 B6) (ON B17 B7) (ON B22 B17)
  (ON B33 B22) (ON B40 B33) (ON B50 B40) (ON B59 B50) (ON B69 B59)
  (ON B70 B69) (CLEAR B70) (ON-TABLE B8) (ON B12 B8) (ON B25 B12)
  (ON B30 B25) (ON B36 B30) (ON B44 B36) (ON B48 B44) (ON B60 B48)
  (ON B65 B60) (CLEAR B65) (ON-TABLE B9) (ON B10 B9) (ON B11 B10)
  (ON B13 B11) (ON B16 B13) (ON B18 B16) (ON B20 B18) (ON B24 B20)
  (ON B26 B24) (ON B67 B26) (ON B73 B67) (ON B78 B73) (CLEAR B78)
  (ON-TABLE B15) (ON B19 B15) (ON B21 B19) (ON B31 B21) (ON B47 B31)
  (ON B63 B47) (ON B75 B63) (ON B80 B75) (CLEAR B80) (ON-TABLE B23)
  (ON B28 B23) (ON B37 B28) (ON B39 B37) (ON B58 B39) (ON B79 B58)
  (CLEAR B79) (ON-TABLE B27) (ON B46 B27) (ON B56 B46) (ON B61 B56)
  (ON B71 B61) (CLEAR B71) (ON-TABLE B29) (ON B35 B29) (ON B38 B35)
  (ON B42 B38) (ON B43 B42) (ON B45 B43) (ON B62 B45) (ON B72 B62)
  (ON B77 B72) (CLEAR B77) (ON-TABLE B32) (ON B34 B32) (ON B49 B34)
  (ON B64 B49) (ON B66 B64) (CLEAR B66) (ON-TABLE B41) (ON B51 B41)
  (CLEAR B51) (ON-TABLE B53) (ON B55 B53) (ON B57 B55) (CLEAR B57)))