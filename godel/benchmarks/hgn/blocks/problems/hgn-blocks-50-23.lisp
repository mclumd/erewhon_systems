(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_23 BLOCKS-HTN
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
  (ON B3 B1) (ON B6 B3) (ON B7 B6) (ON B11 B7) (ON B16 B11)
  (ON B24 B16) (ON B32 B24) (ON B40 B32) (CLEAR B40) (ON-TABLE B2)
  (ON B4 B2) (ON B8 B4) (ON B10 B8) (ON B12 B10) (ON B13 B12)
  (ON B15 B13) (ON B17 B15) (ON B19 B17) (ON B20 B19) (ON B33 B20)
  (CLEAR B33) (ON-TABLE B5) (ON B9 B5) (ON B14 B9) (ON B18 B14)
  (ON B25 B18) (ON B26 B25) (ON B27 B26) (ON B42 B27) (ON B43 B42)
  (ON B50 B43) (CLEAR B50) (ON-TABLE B21) (ON B22 B21) (ON B23 B22)
  (ON B28 B23) (ON B30 B28) (ON B31 B30) (ON B34 B31) (ON B35 B34)
  (ON B37 B35) (ON B38 B37) (ON B49 B38) (CLEAR B49) (ON-TABLE B29)
  (ON B39 B29) (ON B44 B39) (ON B48 B44) (CLEAR B48) (ON-TABLE B36)
  (ON B41 B36) (ON B45 B41) (ON B46 B45) (ON B47 B46) (CLEAR B47))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B6 B3) (ON B7 B6) (ON B10 B7)
  (ON B22 B10) (ON B29 B22) (ON B33 B29) (ON B37 B33) (CLEAR B37)
  (ON-TABLE B4) (ON B5 B4) (ON B8 B5) (ON B19 B8) (ON B20 B19)
  (ON B35 B20) (CLEAR B35) (ON-TABLE B9) (ON B11 B9) (ON B13 B11)
  (ON B21 B13) (ON B23 B21) (ON B26 B23) (ON B27 B26) (CLEAR B27)
  (ON-TABLE B12) (ON B14 B12) (ON B16 B14) (ON B18 B16) (ON B28 B18)
  (ON B32 B28) (ON B34 B32) (ON B39 B34) (ON B49 B39) (CLEAR B49)
  (ON-TABLE B15) (ON B40 B15) (CLEAR B40) (ON-TABLE B17) (ON B24 B17)
  (ON B25 B24) (ON B45 B25) (ON B47 B45) (CLEAR B47) (ON-TABLE B30)
  (ON B31 B30) (ON B36 B31) (ON B38 B36) (ON B43 B38) (ON B46 B43)
  (CLEAR B46) (ON-TABLE B41) (ON B44 B41) (CLEAR B44) (ON-TABLE B42)
  (CLEAR B42) (ON-TABLE B48) (CLEAR B48) (ON-TABLE B50) (CLEAR B50)))