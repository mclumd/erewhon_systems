(IN-PACKAGE SHOP2) 
(DEFPROBLEM P80_15 BLOCKS-HTN
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
  (ON B3 B1) (ON B5 B3) (ON B7 B5) (ON B22 B7) (ON B32 B22)
  (ON B39 B32) (ON B43 B39) (ON B47 B43) (ON B66 B47) (ON B78 B66)
  (CLEAR B78) (ON-TABLE B2) (ON B4 B2) (ON B6 B4) (ON B12 B6)
  (ON B18 B12) (ON B19 B18) (ON B29 B19) (ON B30 B29) (ON B45 B30)
  (ON B70 B45) (CLEAR B70) (ON-TABLE B8) (ON B9 B8) (ON B13 B9)
  (ON B16 B13) (ON B21 B16) (ON B23 B21) (ON B31 B23) (ON B33 B31)
  (ON B36 B33) (ON B37 B36) (ON B71 B37) (ON B75 B71) (CLEAR B75)
  (ON-TABLE B10) (ON B11 B10) (ON B14 B11) (ON B15 B14) (ON B17 B15)
  (ON B20 B17) (ON B24 B20) (ON B26 B24) (ON B28 B26) (ON B38 B28)
  (ON B42 B38) (ON B44 B42) (ON B49 B44) (ON B59 B49) (ON B77 B59)
  (CLEAR B77) (ON-TABLE B25) (ON B50 B25) (ON B64 B50) (ON B68 B64)
  (CLEAR B68) (ON-TABLE B27) (ON B34 B27) (ON B35 B34) (ON B55 B35)
  (ON B57 B55) (ON B65 B57) (ON B73 B65) (CLEAR B73) (ON-TABLE B40)
  (ON B41 B40) (ON B46 B41) (ON B48 B46) (ON B53 B48) (ON B56 B53)
  (ON B62 B56) (CLEAR B62) (ON-TABLE B51) (ON B54 B51) (ON B63 B54)
  (ON B67 B63) (ON B69 B67) (ON B74 B69) (ON B76 B74) (ON B80 B76)
  (CLEAR B80) (ON-TABLE B52) (CLEAR B52) (ON-TABLE B58) (CLEAR B58)
  (ON-TABLE B60) (ON B61 B60) (ON B72 B61) (ON B79 B72) (CLEAR B79))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B6 B5)
  (ON B12 B6) (ON B13 B12) (ON B26 B13) (ON B28 B26) (ON B43 B28)
  (ON B47 B43) (ON B49 B47) (ON B52 B49) (ON B56 B52) (ON B76 B56)
  (CLEAR B76) (ON-TABLE B7) (ON B8 B7) (ON B10 B8) (ON B11 B10)
  (ON B14 B11) (ON B15 B14) (ON B19 B15) (ON B20 B19) (ON B22 B20)
  (ON B31 B22) (ON B58 B31) (ON B63 B58) (ON B71 B63) (CLEAR B71)
  (ON-TABLE B9) (ON B16 B9) (ON B18 B16) (ON B21 B18) (ON B33 B21)
  (ON B42 B33) (ON B55 B42) (ON B78 B55) (ON B80 B78) (CLEAR B80)
  (ON-TABLE B17) (ON B23 B17) (ON B24 B23) (ON B27 B24) (ON B30 B27)
  (ON B64 B30) (ON B66 B64) (ON B72 B66) (CLEAR B72) (ON-TABLE B25)
  (ON B35 B25) (ON B41 B35) (ON B46 B41) (ON B62 B46) (ON B65 B62)
  (CLEAR B65) (ON-TABLE B29) (ON B34 B29) (ON B37 B34) (ON B44 B37)
  (ON B57 B44) (CLEAR B57) (ON-TABLE B32) (ON B38 B32) (ON B39 B38)
  (ON B40 B39) (ON B50 B40) (ON B51 B50) (ON B54 B51) (ON B73 B54)
  (ON B75 B73) (CLEAR B75) (ON-TABLE B36) (ON B45 B36) (ON B48 B45)
  (ON B53 B48) (ON B60 B53) (CLEAR B60) (ON-TABLE B59) (ON B67 B59)
  (CLEAR B67) (ON-TABLE B61) (ON B68 B61) (ON B69 B68) (ON B70 B69)
  (ON B79 B70) (CLEAR B79) (ON-TABLE B74) (ON B77 B74) (CLEAR B77)))