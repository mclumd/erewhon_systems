(IN-PACKAGE SHOP2) 
(DEFPROBLEM P60_14 BLOCKS-HTN
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
  (BLOCK B57) (BLOCK B58) (BLOCK B59) (BLOCK B60) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B6 B5) (ON B7 B6)
  (ON B8 B7) (ON B9 B8) (ON B10 B9) (ON B11 B10) (ON B12 B11)
  (ON B16 B12) (ON B19 B16) (ON B21 B19) (ON B22 B21) (ON B24 B22)
  (ON B37 B24) (ON B39 B37) (ON B47 B39) (CLEAR B47) (ON-TABLE B13)
  (ON B14 B13) (ON B17 B14) (ON B23 B17) (ON B26 B23) (ON B49 B26)
  (ON B54 B49) (ON B58 B54) (CLEAR B58) (ON-TABLE B15) (ON B18 B15)
  (ON B20 B18) (ON B31 B20) (ON B34 B31) (ON B35 B34) (ON B36 B35)
  (ON B45 B36) (ON B51 B45) (ON B52 B51) (ON B56 B52) (CLEAR B56)
  (ON-TABLE B25) (ON B27 B25) (ON B29 B27) (ON B38 B29) (ON B40 B38)
  (ON B46 B40) (CLEAR B46) (ON-TABLE B28) (ON B30 B28) (ON B41 B30)
  (ON B42 B41) (ON B43 B42) (ON B50 B43) (ON B57 B50) (CLEAR B57)
  (ON-TABLE B32) (ON B33 B32) (ON B44 B33) (ON B53 B44) (CLEAR B53)
  (ON-TABLE B48) (ON B60 B48) (CLEAR B60) (ON-TABLE B55) (ON B59 B55)
  (CLEAR B59))
 ((ON-TABLE B1) (ON B7 B1) (ON B10 B7) (ON B21 B10) (ON B23 B21)
  (ON B26 B23) (ON B35 B26) (ON B45 B35) (CLEAR B45) (ON-TABLE B2)
  (ON B3 B2) (ON B16 B3) (ON B18 B16) (ON B19 B18) (ON B25 B19)
  (ON B27 B25) (ON B30 B27) (ON B31 B30) (ON B32 B31) (ON B33 B32)
  (ON B36 B33) (ON B48 B36) (ON B50 B48) (ON B59 B50) (CLEAR B59)
  (ON-TABLE B4) (ON B8 B4) (ON B12 B8) (ON B14 B12) (ON B20 B14)
  (ON B24 B20) (ON B41 B24) (ON B43 B41) (ON B46 B43) (ON B57 B46)
  (ON B60 B57) (CLEAR B60) (ON-TABLE B5) (ON B6 B5) (ON B9 B6)
  (ON B11 B9) (ON B13 B11) (ON B15 B13) (ON B17 B15) (ON B22 B17)
  (ON B28 B22) (ON B52 B28) (ON B58 B52) (CLEAR B58) (ON-TABLE B29)
  (ON B38 B29) (ON B42 B38) (ON B51 B42) (CLEAR B51) (ON-TABLE B34)
  (ON B37 B34) (ON B44 B37) (ON B54 B44) (CLEAR B54) (ON-TABLE B39)
  (ON B40 B39) (ON B49 B40) (ON B55 B49) (ON B56 B55) (CLEAR B56)
  (ON-TABLE B47) (ON B53 B47) (CLEAR B53)))