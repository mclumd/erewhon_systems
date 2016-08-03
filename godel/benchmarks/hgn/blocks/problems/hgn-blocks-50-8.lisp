(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_8 BLOCKS-HTN
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
  (ON B5 B1) (ON B6 B5) (ON B8 B6) (ON B15 B8) (ON B34 B15) (CLEAR B34)
  (ON-TABLE B2) (ON B14 B2) (ON B19 B14) (ON B21 B19) (ON B44 B21)
  (CLEAR B44) (ON-TABLE B3) (ON B10 B3) (ON B20 B10) (ON B25 B20)
  (ON B29 B25) (ON B31 B29) (ON B33 B31) (CLEAR B33) (ON-TABLE B4)
  (ON B7 B4) (ON B11 B7) (ON B23 B11) (ON B26 B23) (ON B28 B26)
  (ON B37 B28) (CLEAR B37) (ON-TABLE B9) (ON B13 B9) (ON B16 B13)
  (ON B18 B16) (ON B24 B18) (ON B32 B24) (ON B35 B32) (ON B36 B35)
  (CLEAR B36) (ON-TABLE B12) (ON B22 B12) (ON B42 B22) (ON B45 B42)
  (CLEAR B45) (ON-TABLE B17) (ON B27 B17) (ON B30 B27) (ON B40 B30)
  (ON B46 B40) (CLEAR B46) (ON-TABLE B38) (ON B49 B38) (ON B50 B49)
  (CLEAR B50) (ON-TABLE B39) (ON B41 B39) (ON B43 B41) (ON B47 B43)
  (CLEAR B47) (ON-TABLE B48) (CLEAR B48))
 ((ON-TABLE B1) (ON B3 B1) (ON B4 B3) (ON B5 B4) (ON B12 B5)
  (ON B13 B12) (ON B21 B13) (ON B31 B21) (CLEAR B31) (ON-TABLE B2)
  (ON B15 B2) (ON B33 B15) (ON B36 B33) (ON B38 B36) (ON B41 B38)
  (ON B43 B41) (ON B48 B43) (ON B49 B48) (CLEAR B49) (ON-TABLE B6)
  (ON B8 B6) (ON B14 B8) (ON B24 B14) (ON B25 B24) (ON B40 B25)
  (CLEAR B40) (ON-TABLE B7) (ON B18 B7) (ON B19 B18) (ON B29 B19)
  (ON B44 B29) (CLEAR B44) (ON-TABLE B9) (ON B26 B9) (ON B27 B26)
  (ON B30 B27) (ON B42 B30) (CLEAR B42) (ON-TABLE B10) (ON B22 B10)
  (ON B47 B22) (CLEAR B47) (ON-TABLE B11) (ON B16 B11) (ON B20 B16)
  (ON B23 B20) (ON B28 B23) (ON B39 B28) (ON B46 B39) (CLEAR B46)
  (ON-TABLE B17) (ON B35 B17) (ON B37 B35) (CLEAR B37) (ON-TABLE B32)
  (ON B34 B32) (CLEAR B34) (ON-TABLE B45) (ON B50 B45) (CLEAR B50)))