(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_19 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (BLOCK B41)
  (BLOCK B42) (BLOCK B43) (BLOCK B44) (BLOCK B45) (BLOCK B46)
  (BLOCK B47) (BLOCK B48) (BLOCK B49) (BLOCK B50) (ON-TABLE B1)
  (ON B3 B1) (ON B6 B3) (ON B7 B6) (ON B9 B7) (ON B20 B9) (ON B22 B20)
  (ON B26 B22) (ON B31 B26) (ON B40 B31) (ON B49 B40) (CLEAR B49)
  (ON-TABLE B2) (ON B5 B2) (ON B8 B5) (ON B10 B8) (ON B11 B10)
  (ON B15 B11) (ON B17 B15) (ON B35 B17) (ON B37 B35) (ON B41 B37)
  (CLEAR B41) (ON-TABLE B4) (ON B16 B4) (ON B28 B16) (ON B29 B28)
  (ON B34 B29) (ON B39 B34) (CLEAR B39) (ON-TABLE B12) (ON B25 B12)
  (ON B38 B25) (ON B44 B38) (ON B47 B44) (CLEAR B47) (ON-TABLE B13)
  (ON B14 B13) (ON B18 B14) (ON B19 B18) (CLEAR B19) (ON-TABLE B21)
  (ON B27 B21) (ON B36 B27) (CLEAR B36) (ON-TABLE B23) (ON B24 B23)
  (ON B32 B24) (ON B33 B32) (CLEAR B33) (ON-TABLE B30) (ON B46 B30)
  (CLEAR B46) (ON-TABLE B42) (ON B43 B42) (CLEAR B43) (ON-TABLE B45)
  (ON B48 B45) (ON B50 B48) (CLEAR B50))
 ((ON-TABLE B1) (ON B5 B1) (ON B7 B5) (ON B15 B7) (ON B23 B15)
  (ON B28 B23) (ON B35 B28) (CLEAR B35) (ON-TABLE B2) (ON B3 B2)
  (ON B17 B3) (ON B22 B17) (ON B32 B22) (ON B38 B32) (ON B42 B38)
  (ON B47 B42) (CLEAR B47) (ON-TABLE B4) (ON B6 B4) (ON B9 B6)
  (ON B10 B9) (ON B12 B10) (ON B20 B12) (ON B25 B20) (ON B31 B25)
  (ON B46 B31) (CLEAR B46) (ON-TABLE B8) (ON B11 B8) (ON B13 B11)
  (ON B14 B13) (ON B16 B14) (ON B18 B16) (ON B36 B18) (CLEAR B36)
  (ON-TABLE B19) (ON B21 B19) (ON B26 B21) (ON B29 B26) (CLEAR B29)
  (ON-TABLE B24) (ON B27 B24) (ON B34 B27) (ON B37 B34) (ON B40 B37)
  (ON B41 B40) (CLEAR B41) (ON-TABLE B30) (ON B33 B30) (ON B43 B33)
  (ON B44 B43) (ON B49 B44) (ON B50 B49) (CLEAR B50) (ON-TABLE B39)
  (CLEAR B39) (ON-TABLE B45) (ON B48 B45) (CLEAR B48)))