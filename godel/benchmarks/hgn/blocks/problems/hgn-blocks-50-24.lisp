(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_24 BLOCKS-HTN
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
  (ON B2 B1) (ON B6 B2) (ON B12 B6) (ON B13 B12) (ON B16 B13)
  (ON B22 B16) (ON B32 B22) (CLEAR B32) (ON-TABLE B3) (ON B4 B3)
  (ON B8 B4) (ON B10 B8) (ON B20 B10) (ON B21 B20) (ON B30 B21)
  (ON B31 B30) (ON B34 B31) (CLEAR B34) (ON-TABLE B5) (ON B11 B5)
  (ON B14 B11) (ON B17 B14) (ON B18 B17) (ON B23 B18) (ON B24 B23)
  (ON B25 B24) (ON B26 B25) (ON B41 B26) (ON B48 B41) (CLEAR B48)
  (ON-TABLE B7) (ON B9 B7) (ON B15 B9) (ON B37 B15) (ON B43 B37)
  (CLEAR B43) (ON-TABLE B19) (ON B33 B19) (ON B45 B33) (ON B46 B45)
  (ON B50 B46) (CLEAR B50) (ON-TABLE B27) (ON B28 B27) (ON B35 B28)
  (ON B38 B35) (CLEAR B38) (ON-TABLE B29) (ON B36 B29) (ON B42 B36)
  (CLEAR B42) (ON-TABLE B39) (ON B47 B39) (CLEAR B47) (ON-TABLE B40)
  (ON B44 B40) (CLEAR B44) (ON-TABLE B49) (CLEAR B49))
 ((ON-TABLE B1) (ON B5 B1) (ON B8 B5) (ON B13 B8) (ON B18 B13)
  (ON B22 B18) (ON B25 B22) (ON B27 B25) (ON B32 B27) (ON B44 B32)
  (CLEAR B44) (ON-TABLE B2) (ON B4 B2) (ON B15 B4) (ON B24 B15)
  (ON B36 B24) (CLEAR B36) (ON-TABLE B3) (ON B12 B3) (ON B42 B12)
  (ON B45 B42) (ON B46 B45) (CLEAR B46) (ON-TABLE B6) (ON B9 B6)
  (ON B10 B9) (ON B19 B10) (ON B31 B19) (ON B33 B31) (CLEAR B33)
  (ON-TABLE B7) (ON B11 B7) (ON B28 B11) (ON B29 B28) (ON B41 B29)
  (ON B47 B41) (ON B50 B47) (CLEAR B50) (ON-TABLE B14) (ON B21 B14)
  (ON B23 B21) (ON B26 B23) (ON B30 B26) (ON B40 B30) (ON B49 B40)
  (CLEAR B49) (ON-TABLE B16) (ON B17 B16) (ON B20 B17) (ON B34 B20)
  (ON B35 B34) (ON B38 B35) (ON B43 B38) (CLEAR B43) (ON-TABLE B37)
  (CLEAR B37) (ON-TABLE B39) (ON B48 B39) (CLEAR B48)))