(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_11 BLOCKS-HTN
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
  (ON B2 B1) (ON B4 B2) (ON B6 B4) (ON B7 B6) (ON B27 B7) (ON B28 B27)
  (ON B29 B28) (ON B38 B29) (ON B42 B38) (ON B43 B42) (ON B44 B43)
  (ON B45 B44) (ON B48 B45) (CLEAR B48) (ON-TABLE B3) (ON B5 B3)
  (ON B22 B5) (ON B23 B22) (ON B31 B23) (ON B50 B31) (CLEAR B50)
  (ON-TABLE B8) (ON B9 B8) (ON B10 B9) (ON B13 B10) (ON B14 B13)
  (ON B19 B14) (ON B20 B19) (ON B36 B20) (ON B40 B36) (CLEAR B40)
  (ON-TABLE B11) (ON B12 B11) (ON B16 B12) (ON B17 B16) (ON B18 B17)
  (ON B26 B18) (ON B34 B26) (ON B35 B34) (CLEAR B35) (ON-TABLE B15)
  (ON B21 B15) (ON B24 B21) (ON B25 B24) (ON B37 B25) (ON B39 B37)
  (ON B47 B39) (ON B49 B47) (CLEAR B49) (ON-TABLE B30) (ON B32 B30)
  (ON B33 B32) (ON B41 B33) (ON B46 B41) (CLEAR B46))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B12 B3) (ON B13 B12)
  (ON B26 B13) (ON B36 B26) (ON B45 B36) (CLEAR B45) (ON-TABLE B4)
  (ON B8 B4) (ON B14 B8) (ON B20 B14) (ON B27 B20) (ON B29 B27)
  (ON B35 B29) (ON B38 B35) (ON B39 B38) (ON B49 B39) (CLEAR B49)
  (ON-TABLE B5) (ON B15 B5) (ON B16 B15) (ON B17 B16) (ON B22 B17)
  (ON B24 B22) (ON B33 B24) (ON B48 B33) (ON B50 B48) (CLEAR B50)
  (ON-TABLE B6) (ON B7 B6) (ON B10 B7) (ON B18 B10) (ON B19 B18)
  (ON B21 B19) (ON B28 B21) (ON B31 B28) (CLEAR B31) (ON-TABLE B9)
  (ON B11 B9) (ON B25 B11) (ON B30 B25) (CLEAR B30) (ON-TABLE B23)
  (ON B34 B23) (ON B37 B34) (ON B47 B37) (CLEAR B47) (ON-TABLE B32)
  (CLEAR B32) (ON-TABLE B40) (ON B46 B40) (CLEAR B46) (ON-TABLE B41)
  (ON B43 B41) (ON B44 B43) (CLEAR B44) (ON-TABLE B42) (CLEAR B42)))