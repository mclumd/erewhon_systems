(IN-PACKAGE SHOP2) 
(DEFPROBLEM P60_24 BLOCKS-HTN
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
  (ON B12 B1) (ON B15 B12) (ON B16 B15) (ON B18 B16) (ON B21 B18)
  (ON B23 B21) (ON B32 B23) (ON B36 B32) (ON B44 B36) (ON B49 B44)
  (CLEAR B49) (ON-TABLE B2) (ON B5 B2) (ON B6 B5) (ON B7 B6)
  (ON B25 B7) (ON B26 B25) (ON B27 B26) (ON B38 B27) (ON B40 B38)
  (ON B42 B40) (ON B43 B42) (ON B51 B43) (ON B56 B51) (ON B58 B56)
  (CLEAR B58) (ON-TABLE B3) (ON B4 B3) (ON B11 B4) (ON B14 B11)
  (ON B19 B14) (ON B22 B19) (ON B28 B22) (ON B33 B28) (ON B35 B33)
  (ON B47 B35) (ON B50 B47) (ON B54 B50) (CLEAR B54) (ON-TABLE B8)
  (ON B9 B8) (ON B10 B9) (ON B13 B10) (ON B17 B13) (ON B20 B17)
  (ON B24 B20) (ON B31 B24) (ON B52 B31) (ON B53 B52) (CLEAR B53)
  (ON-TABLE B29) (ON B30 B29) (ON B37 B30) (ON B39 B37) (ON B45 B39)
  (ON B48 B45) (ON B60 B48) (CLEAR B60) (ON-TABLE B34) (ON B41 B34)
  (ON B55 B41) (CLEAR B55) (ON-TABLE B46) (ON B59 B46) (CLEAR B59)
  (ON-TABLE B57) (CLEAR B57))
 ((ON-TABLE B1) (ON B21 B1) (ON B25 B21) (ON B50 B25) (CLEAR B50)
  (ON-TABLE B2) (ON B5 B2) (ON B8 B5) (ON B16 B8) (ON B20 B16)
  (ON B32 B20) (ON B34 B32) (ON B49 B34) (ON B53 B49) (ON B55 B53)
  (CLEAR B55) (ON-TABLE B3) (ON B4 B3) (ON B7 B4) (ON B17 B7)
  (ON B47 B17) (ON B54 B47) (CLEAR B54) (ON-TABLE B6) (ON B11 B6)
  (ON B12 B11) (ON B19 B12) (ON B31 B19) (ON B40 B31) (ON B43 B40)
  (ON B44 B43) (ON B56 B44) (CLEAR B56) (ON-TABLE B9) (ON B13 B9)
  (ON B14 B13) (ON B26 B14) (ON B33 B26) (ON B35 B33) (ON B39 B35)
  (ON B42 B39) (ON B51 B42) (CLEAR B51) (ON-TABLE B10) (ON B15 B10)
  (ON B22 B15) (ON B23 B22) (ON B24 B23) (ON B41 B24) (ON B59 B41)
  (CLEAR B59) (ON-TABLE B18) (ON B29 B18) (ON B37 B29) (ON B45 B37)
  (ON B46 B45) (CLEAR B46) (ON-TABLE B27) (ON B28 B27) (ON B30 B28)
  (ON B57 B30) (CLEAR B57) (ON-TABLE B36) (ON B38 B36) (CLEAR B38)
  (ON-TABLE B48) (ON B58 B48) (CLEAR B58) (ON-TABLE B52) (ON B60 B52)
  (CLEAR B60)))