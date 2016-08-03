(IN-PACKAGE SHOP2) 
(DEFPROBLEM P70_1 BLOCKS-HTN
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
  (BLOCK B67) (BLOCK B68) (BLOCK B69) (BLOCK B70) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B14 B3) (ON B17 B14) (ON B23 B17)
  (ON B24 B23) (ON B64 B24) (CLEAR B64) (ON-TABLE B4) (ON B5 B4)
  (ON B6 B5) (ON B13 B6) (ON B22 B13) (ON B26 B22) (ON B29 B26)
  (ON B30 B29) (ON B35 B30) (ON B44 B35) (ON B51 B44) (ON B56 B51)
  (CLEAR B56) (ON-TABLE B7) (ON B11 B7) (ON B12 B11) (ON B34 B12)
  (ON B42 B34) (ON B65 B42) (ON B67 B65) (CLEAR B67) (ON-TABLE B8)
  (ON B9 B8) (ON B31 B9) (ON B36 B31) (ON B41 B36) (ON B61 B41)
  (ON B69 B61) (CLEAR B69) (ON-TABLE B10) (ON B27 B10) (ON B37 B27)
  (ON B48 B37) (CLEAR B48) (ON-TABLE B15) (ON B21 B15) (ON B25 B21)
  (ON B38 B25) (ON B47 B38) (ON B66 B47) (CLEAR B66) (ON-TABLE B16)
  (ON B19 B16) (ON B32 B19) (ON B45 B32) (CLEAR B45) (ON-TABLE B18)
  (ON B28 B18) (ON B50 B28) (ON B68 B50) (CLEAR B68) (ON-TABLE B20)
  (ON B55 B20) (CLEAR B55) (ON-TABLE B33) (ON B49 B33) (ON B60 B49)
  (CLEAR B60) (ON-TABLE B39) (ON B40 B39) (ON B57 B40) (ON B58 B57)
  (ON B62 B58) (CLEAR B62) (ON-TABLE B43) (ON B59 B43) (ON B63 B59)
  (CLEAR B63) (ON-TABLE B46) (ON B54 B46) (ON B70 B54) (CLEAR B70)
  (ON-TABLE B52) (ON B53 B52) (CLEAR B53))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B6 B3) (ON B11 B6)
  (ON B18 B11) (ON B21 B18) (ON B22 B21) (ON B23 B22) (ON B27 B23)
  (ON B43 B27) (ON B52 B43) (ON B53 B52) (CLEAR B53) (ON-TABLE B4)
  (ON B5 B4) (ON B9 B5) (ON B13 B9) (ON B14 B13) (ON B19 B14)
  (ON B31 B19) (ON B32 B31) (ON B39 B32) (ON B61 B39) (ON B63 B61)
  (CLEAR B63) (ON-TABLE B7) (ON B8 B7) (ON B15 B8) (ON B16 B15)
  (ON B20 B16) (ON B24 B20) (ON B37 B24) (ON B47 B37) (ON B59 B47)
  (ON B65 B59) (CLEAR B65) (ON-TABLE B10) (ON B12 B10) (ON B17 B12)
  (ON B25 B17) (ON B26 B25) (ON B28 B26) (ON B29 B28) (ON B33 B29)
  (ON B35 B33) (ON B42 B35) (ON B48 B42) (CLEAR B48) (ON-TABLE B30)
  (ON B34 B30) (ON B49 B34) (ON B50 B49) (ON B62 B50) (ON B64 B62)
  (CLEAR B64) (ON-TABLE B36) (ON B38 B36) (ON B55 B38) (ON B60 B55)
  (ON B67 B60) (ON B69 B67) (ON B70 B69) (CLEAR B70) (ON-TABLE B40)
  (ON B44 B40) (ON B46 B44) (ON B51 B46) (ON B56 B51) (CLEAR B56)
  (ON-TABLE B41) (ON B68 B41) (CLEAR B68) (ON-TABLE B45) (ON B54 B45)
  (ON B58 B54) (CLEAR B58) (ON-TABLE B57) (CLEAR B57) (ON-TABLE B66)
  (CLEAR B66)))