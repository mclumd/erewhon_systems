(IN-PACKAGE SHOP2) 
(DEFPROBLEM P50_2 BLOCKS-HTN
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
  (ON B3 B1) (ON B5 B3) (ON B13 B5) (ON B14 B13) (ON B16 B14)
  (ON B17 B16) (ON B20 B17) (ON B21 B20) (ON B24 B21) (ON B30 B24)
  (CLEAR B30) (ON-TABLE B2) (ON B4 B2) (ON B7 B4) (ON B18 B7)
  (ON B25 B18) (ON B36 B25) (ON B39 B36) (ON B40 B39) (ON B46 B40)
  (CLEAR B46) (ON-TABLE B6) (ON B15 B6) (ON B22 B15) (ON B26 B22)
  (ON B37 B26) (ON B42 B37) (CLEAR B42) (ON-TABLE B8) (ON B10 B8)
  (ON B11 B10) (ON B12 B11) (ON B27 B12) (ON B32 B27) (ON B34 B32)
  (ON B43 B34) (ON B45 B43) (ON B49 B45) (CLEAR B49) (ON-TABLE B9)
  (ON B19 B9) (ON B23 B19) (ON B28 B23) (ON B29 B28) (ON B33 B29)
  (ON B41 B33) (CLEAR B41) (ON-TABLE B31) (ON B35 B31) (ON B44 B35)
  (CLEAR B44) (ON-TABLE B38) (ON B47 B38) (ON B48 B47) (CLEAR B48)
  (ON-TABLE B50) (CLEAR B50))
 ((ON-TABLE B1) (ON B3 B1) (ON B6 B3) (ON B10 B6) (ON B13 B10)
  (ON B22 B13) (ON B26 B22) (ON B27 B26) (ON B29 B27) (ON B36 B29)
  (ON B37 B36) (ON B43 B37) (CLEAR B43) (ON-TABLE B2) (ON B8 B2)
  (ON B11 B8) (ON B16 B11) (ON B20 B16) (ON B33 B20) (ON B42 B33)
  (CLEAR B42) (ON-TABLE B4) (ON B5 B4) (ON B17 B5) (ON B21 B17)
  (ON B35 B21) (ON B45 B35) (ON B49 B45) (CLEAR B49) (ON-TABLE B7)
  (ON B12 B7) (ON B19 B12) (CLEAR B19) (ON-TABLE B9) (ON B15 B9)
  (ON B23 B15) (ON B41 B23) (ON B50 B41) (CLEAR B50) (ON-TABLE B14)
  (ON B28 B14) (ON B30 B28) (ON B31 B30) (ON B48 B31) (CLEAR B48)
  (ON-TABLE B18) (ON B24 B18) (ON B25 B24) (ON B46 B25) (CLEAR B46)
  (ON-TABLE B32) (ON B34 B32) (ON B38 B34) (ON B39 B38) (ON B40 B39)
  (CLEAR B40) (ON-TABLE B44) (CLEAR B44) (ON-TABLE B47) (CLEAR B47)))