(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_18 BLOCKS-HTN
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
  (ON B3 B1) (ON B4 B3) (ON B19 B4) (ON B26 B19) (ON B28 B26)
  (ON B33 B28) (ON B34 B33) (ON B37 B34) (ON B42 B37) (ON B44 B42)
  (CLEAR B44) (ON-TABLE B2) (ON B6 B2) (ON B8 B6) (ON B9 B8)
  (ON B14 B9) (ON B15 B14) (ON B16 B15) (ON B18 B16) (ON B25 B18)
  (ON B27 B25) (ON B35 B27) (ON B36 B35) (ON B49 B36) (CLEAR B49)
  (ON-TABLE B5) (ON B7 B5) (ON B10 B7) (ON B12 B10) (ON B23 B12)
  (ON B29 B23) (ON B41 B29) (ON B45 B41) (ON B47 B45) (ON B50 B47)
  (CLEAR B50) (ON-TABLE B11) (ON B17 B11) (ON B20 B17) (ON B22 B20)
  (ON B31 B22) (ON B32 B31) (CLEAR B32) (ON-TABLE B13) (ON B21 B13)
  (ON B24 B21) (ON B30 B24) (ON B38 B30) (ON B40 B38) (ON B43 B40)
  (ON B46 B43) (CLEAR B46) (ON-TABLE B39) (ON B48 B39) (CLEAR B48))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B7 B3) (ON B32 B7)
  (ON B50 B32) (CLEAR B50) (ON-TABLE B4) (ON B13 B4) (ON B16 B13)
  (ON B21 B16) (ON B25 B21) (ON B41 B25) (ON B47 B41) (ON B48 B47)
  (CLEAR B48) (ON-TABLE B5) (ON B6 B5) (ON B26 B6) (ON B33 B26)
  (ON B39 B33) (ON B46 B39) (CLEAR B46) (ON-TABLE B8) (ON B10 B8)
  (ON B12 B10) (ON B14 B12) (ON B18 B14) (ON B19 B18) (ON B27 B19)
  (ON B28 B27) (ON B30 B28) (CLEAR B30) (ON-TABLE B9) (ON B11 B9)
  (ON B15 B11) (ON B22 B15) (ON B29 B22) (ON B40 B29) (CLEAR B40)
  (ON-TABLE B17) (ON B24 B17) (ON B38 B24) (ON B44 B38) (CLEAR B44)
  (ON-TABLE B20) (ON B23 B20) (ON B31 B23) (ON B35 B31) (CLEAR B35)
  (ON-TABLE B34) (ON B36 B34) (ON B45 B36) (CLEAR B45) (ON-TABLE B37)
  (CLEAR B37) (ON-TABLE B42) (ON B49 B42) (CLEAR B49) (ON-TABLE B43)
  (CLEAR B43)))