(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_21 BLOCKS-HTN
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
  (ON B4 B1) (ON B24 B4) (ON B26 B24) (ON B28 B26) (ON B32 B28)
  (CLEAR B32) (ON-TABLE B2) (ON B5 B2) (ON B7 B5) (ON B15 B7)
  (ON B16 B15) (ON B22 B16) (ON B25 B22) (ON B30 B25) (ON B36 B30)
  (ON B37 B36) (CLEAR B37) (ON-TABLE B3) (ON B6 B3) (ON B9 B6)
  (ON B11 B9) (ON B17 B11) (ON B44 B17) (CLEAR B44) (ON-TABLE B8)
  (ON B19 B8) (ON B39 B19) (ON B47 B39) (CLEAR B47) (ON-TABLE B10)
  (ON B14 B10) (ON B18 B14) (ON B21 B18) (ON B45 B21) (CLEAR B45)
  (ON-TABLE B12) (ON B20 B12) (ON B29 B20) (ON B31 B29) (ON B33 B31)
  (ON B46 B33) (CLEAR B46) (ON-TABLE B13) (ON B23 B13) (ON B27 B23)
  (ON B49 B27) (CLEAR B49) (ON-TABLE B34) (ON B42 B34) (CLEAR B42)
  (ON-TABLE B35) (ON B38 B35) (ON B41 B38) (ON B48 B41) (CLEAR B48)
  (ON-TABLE B40) (ON B43 B40) (CLEAR B43) (ON-TABLE B50) (CLEAR B50))
 ((ON-TABLE B1) (ON B2 B1) (ON B4 B2) (ON B6 B4) (ON B7 B6) (ON B11 B7)
  (ON B12 B11) (ON B16 B12) (ON B40 B16) (CLEAR B40) (ON-TABLE B3)
  (ON B9 B3) (ON B27 B9) (ON B34 B27) (ON B43 B34) (CLEAR B43)
  (ON-TABLE B5) (ON B8 B5) (ON B10 B8) (ON B14 B10) (ON B17 B14)
  (ON B19 B17) (ON B22 B19) (ON B33 B22) (ON B37 B33) (ON B42 B37)
  (ON B49 B42) (CLEAR B49) (ON-TABLE B13) (ON B20 B13) (ON B26 B20)
  (ON B30 B26) (ON B31 B30) (ON B36 B31) (ON B44 B36) (ON B45 B44)
  (CLEAR B45) (ON-TABLE B15) (ON B18 B15) (ON B24 B18) (ON B39 B24)
  (ON B41 B39) (CLEAR B41) (ON-TABLE B21) (CLEAR B21) (ON-TABLE B23)
  (ON B25 B23) (ON B28 B25) (ON B29 B28) (ON B32 B29) (ON B35 B32)
  (ON B46 B35) (CLEAR B46) (ON-TABLE B38) (CLEAR B38) (ON-TABLE B47)
  (CLEAR B47) (ON-TABLE B48) (ON B50 B48) (CLEAR B50)))