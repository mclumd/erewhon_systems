(IN-PACKAGE SHOP2) 
(DEFPROBLEM P70_4 BLOCKS-HTN
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
  (ON B3 B1) (ON B15 B3) (ON B19 B15) (ON B28 B19) (ON B30 B28)
  (ON B31 B30) (ON B34 B31) (ON B38 B34) (ON B61 B38) (CLEAR B61)
  (ON-TABLE B2) (ON B5 B2) (ON B11 B5) (ON B21 B11) (ON B22 B21)
  (ON B29 B22) (ON B32 B29) (ON B33 B32) (ON B45 B33) (ON B46 B45)
  (ON B54 B46) (CLEAR B54) (ON-TABLE B4) (ON B7 B4) (ON B10 B7)
  (ON B18 B10) (ON B35 B18) (ON B36 B35) (ON B41 B36) (ON B64 B41)
  (CLEAR B64) (ON-TABLE B6) (ON B9 B6) (ON B23 B9) (ON B51 B23)
  (ON B62 B51) (ON B65 B62) (CLEAR B65) (ON-TABLE B8) (ON B12 B8)
  (ON B13 B12) (ON B14 B13) (ON B37 B14) (ON B39 B37) (ON B56 B39)
  (ON B66 B56) (ON B70 B66) (CLEAR B70) (ON-TABLE B16) (ON B17 B16)
  (ON B20 B17) (ON B24 B20) (ON B25 B24) (ON B26 B25) (ON B27 B26)
  (ON B40 B27) (ON B49 B40) (ON B63 B49) (CLEAR B63) (ON-TABLE B42)
  (ON B53 B42) (ON B69 B53) (CLEAR B69) (ON-TABLE B43) (ON B44 B43)
  (CLEAR B44) (ON-TABLE B47) (ON B57 B47) (ON B58 B57) (ON B59 B58)
  (ON B68 B59) (CLEAR B68) (ON-TABLE B48) (ON B52 B48) (CLEAR B52)
  (ON-TABLE B50) (ON B55 B50) (ON B60 B55) (ON B67 B60) (CLEAR B67))
 ((ON-TABLE B1) (ON B2 B1) (ON B5 B2) (ON B6 B5) (ON B7 B6) (ON B9 B7)
  (ON B14 B9) (ON B39 B14) (ON B50 B39) (ON B54 B50) (ON B59 B54)
  (ON B62 B59) (ON B64 B62) (CLEAR B64) (ON-TABLE B3) (ON B4 B3)
  (ON B8 B4) (ON B12 B8) (ON B20 B12) (ON B24 B20) (ON B28 B24)
  (ON B48 B28) (ON B60 B48) (ON B70 B60) (CLEAR B70) (ON-TABLE B10)
  (ON B13 B10) (ON B15 B13) (ON B25 B15) (ON B27 B25) (ON B35 B27)
  (ON B46 B35) (ON B55 B46) (ON B66 B55) (ON B68 B66) (CLEAR B68)
  (ON-TABLE B11) (ON B21 B11) (ON B22 B21) (ON B38 B22) (ON B41 B38)
  (ON B65 B41) (ON B69 B65) (CLEAR B69) (ON-TABLE B16) (ON B18 B16)
  (ON B32 B18) (ON B61 B32) (CLEAR B61) (ON-TABLE B17) (ON B23 B17)
  (ON B36 B23) (ON B42 B36) (ON B56 B42) (ON B57 B56) (CLEAR B57)
  (ON-TABLE B19) (ON B26 B19) (ON B34 B26) (ON B37 B34) (ON B58 B37)
  (ON B67 B58) (CLEAR B67) (ON-TABLE B29) (ON B30 B29) (ON B31 B30)
  (ON B33 B31) (ON B51 B33) (ON B52 B51) (CLEAR B52) (ON-TABLE B40)
  (ON B43 B40) (ON B44 B43) (ON B45 B44) (ON B49 B45) (ON B53 B49)
  (ON B63 B53) (CLEAR B63) (ON-TABLE B47) (CLEAR B47)))