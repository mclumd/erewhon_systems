(IN-PACKAGE SHOP2) 
(DEFPROBLEM P70_3 BLOCKS-HTN
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
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B9 B5) (ON B10 B9)
  (ON B12 B10) (ON B15 B12) (ON B60 B15) (CLEAR B60) (ON-TABLE B6)
  (ON B7 B6) (ON B8 B7) (ON B13 B8) (ON B14 B13) (ON B47 B14)
  (CLEAR B47) (ON-TABLE B11) (ON B34 B11) (ON B55 B34) (CLEAR B55)
  (ON-TABLE B16) (ON B57 B16) (CLEAR B57) (ON-TABLE B17) (ON B21 B17)
  (ON B23 B21) (ON B35 B23) (ON B44 B35) (ON B52 B44) (ON B56 B52)
  (ON B61 B56) (ON B66 B61) (CLEAR B66) (ON-TABLE B18) (ON B19 B18)
  (ON B24 B19) (ON B26 B24) (ON B41 B26) (ON B65 B41) (CLEAR B65)
  (ON-TABLE B20) (ON B43 B20) (ON B58 B43) (ON B69 B58) (CLEAR B69)
  (ON-TABLE B22) (ON B36 B22) (ON B40 B36) (ON B45 B40) (ON B70 B45)
  (CLEAR B70) (ON-TABLE B25) (ON B27 B25) (ON B28 B27) (ON B30 B28)
  (ON B32 B30) (ON B33 B32) (ON B51 B33) (ON B64 B51) (CLEAR B64)
  (ON-TABLE B29) (ON B38 B29) (ON B48 B38) (ON B49 B48) (CLEAR B49)
  (ON-TABLE B31) (ON B37 B31) (ON B39 B37) (ON B53 B39) (ON B62 B53)
  (ON B63 B62) (CLEAR B63) (ON-TABLE B42) (ON B46 B42) (ON B59 B46)
  (ON B67 B59) (CLEAR B67) (ON-TABLE B50) (CLEAR B50) (ON-TABLE B54)
  (CLEAR B54) (ON-TABLE B68) (CLEAR B68))
 ((ON-TABLE B1) (ON B2 B1) (ON B4 B2) (ON B9 B4) (ON B14 B9)
  (ON B18 B14) (ON B24 B18) (ON B25 B24) (ON B29 B25) (ON B43 B29)
  (ON B44 B43) (ON B59 B44) (CLEAR B59) (ON-TABLE B3) (ON B5 B3)
  (ON B7 B5) (ON B12 B7) (ON B13 B12) (ON B15 B13) (ON B16 B15)
  (ON B20 B16) (ON B23 B20) (ON B39 B23) (ON B46 B39) (ON B49 B46)
  (CLEAR B49) (ON-TABLE B6) (ON B19 B6) (ON B26 B19) (ON B28 B26)
  (ON B33 B28) (ON B45 B33) (ON B48 B45) (ON B52 B48) (ON B54 B52)
  (ON B55 B54) (ON B65 B55) (ON B70 B65) (CLEAR B70) (ON-TABLE B8)
  (ON B11 B8) (ON B17 B11) (ON B31 B17) (ON B32 B31) (ON B37 B32)
  (ON B38 B37) (ON B41 B38) (ON B50 B41) (ON B57 B50) (ON B63 B57)
  (CLEAR B63) (ON-TABLE B10) (ON B21 B10) (ON B27 B21) (ON B35 B27)
  (ON B51 B35) (ON B56 B51) (ON B68 B56) (CLEAR B68) (ON-TABLE B22)
  (ON B36 B22) (ON B53 B36) (ON B60 B53) (ON B64 B60) (ON B66 B64)
  (CLEAR B66) (ON-TABLE B30) (ON B58 B30) (ON B61 B58) (ON B62 B61)
  (ON B67 B62) (CLEAR B67) (ON-TABLE B34) (ON B40 B34) (ON B42 B40)
  (CLEAR B42) (ON-TABLE B47) (CLEAR B47) (ON-TABLE B69) (CLEAR B69)))