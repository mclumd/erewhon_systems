(IN-PACKAGE SHOP2) 
(DEFPROBLEM P70_11 BLOCKS-HTN
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
  (ON B3 B1) (ON B6 B3) (ON B16 B6) (ON B17 B16) (ON B22 B17)
  (ON B36 B22) (ON B50 B36) (ON B51 B50) (ON B53 B51) (ON B64 B53)
  (ON B67 B64) (CLEAR B67) (ON-TABLE B2) (ON B4 B2) (ON B5 B4)
  (ON B7 B5) (ON B10 B7) (ON B11 B10) (ON B12 B11) (ON B14 B12)
  (ON B15 B14) (ON B21 B15) (ON B40 B21) (ON B45 B40) (ON B57 B45)
  (ON B66 B57) (ON B68 B66) (ON B70 B68) (CLEAR B70) (ON-TABLE B8)
  (ON B18 B8) (ON B19 B18) (ON B27 B19) (ON B30 B27) (ON B42 B30)
  (ON B43 B42) (ON B44 B43) (ON B47 B44) (ON B58 B47) (CLEAR B58)
  (ON-TABLE B9) (ON B13 B9) (ON B20 B13) (ON B24 B20) (ON B28 B24)
  (ON B29 B28) (ON B33 B29) (ON B34 B33) (ON B41 B34) (ON B48 B41)
  (ON B65 B48) (ON B69 B65) (CLEAR B69) (ON-TABLE B23) (ON B25 B23)
  (ON B26 B25) (ON B31 B26) (ON B32 B31) (ON B35 B32) (ON B37 B35)
  (ON B38 B37) (ON B39 B38) (ON B49 B39) (ON B54 B49) (ON B56 B54)
  (ON B62 B56) (CLEAR B62) (ON-TABLE B46) (ON B52 B46) (ON B55 B52)
  (ON B59 B55) (ON B60 B59) (ON B61 B60) (ON B63 B61) (CLEAR B63))
 ((ON-TABLE B1) (ON B5 B1) (ON B9 B5) (ON B11 B9) (ON B15 B11)
  (ON B17 B15) (ON B19 B17) (ON B21 B19) (ON B22 B21) (ON B41 B22)
  (ON B49 B41) (CLEAR B49) (ON-TABLE B2) (ON B4 B2) (ON B8 B4)
  (ON B18 B8) (ON B23 B18) (ON B30 B23) (ON B42 B30) (ON B43 B42)
  (ON B51 B43) (ON B52 B51) (ON B61 B52) (ON B62 B61) (ON B64 B62)
  (ON B69 B64) (CLEAR B69) (ON-TABLE B3) (ON B12 B3) (ON B14 B12)
  (ON B20 B14) (ON B29 B20) (ON B37 B29) (ON B38 B37) (ON B46 B38)
  (ON B47 B46) (ON B48 B47) (ON B60 B48) (ON B65 B60) (ON B67 B65)
  (CLEAR B67) (ON-TABLE B6) (ON B13 B6) (ON B16 B13) (ON B25 B16)
  (ON B27 B25) (ON B28 B27) (ON B31 B28) (ON B35 B31) (ON B36 B35)
  (ON B50 B36) (ON B57 B50) (ON B58 B57) (CLEAR B58) (ON-TABLE B7)
  (ON B10 B7) (ON B24 B10) (ON B39 B24) (ON B44 B39) (ON B55 B44)
  (ON B68 B55) (CLEAR B68) (ON-TABLE B26) (ON B32 B26) (ON B33 B32)
  (ON B34 B33) (ON B53 B34) (CLEAR B53) (ON-TABLE B40) (ON B45 B40)
  (ON B54 B45) (CLEAR B54) (ON-TABLE B56) (ON B59 B56) (ON B63 B59)
  (CLEAR B63) (ON-TABLE B66) (CLEAR B66) (ON-TABLE B70) (CLEAR B70)))