(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_8 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B14 B5) (CLEAR B14)
  (ON-TABLE B6) (ON B7 B6) (ON B17 B7) (ON B22 B17) (ON B33 B22)
  (ON B40 B33) (CLEAR B40) (ON-TABLE B8) (ON B12 B8) (ON B25 B12)
  (ON B30 B25) (ON B36 B30) (CLEAR B36) (ON-TABLE B9) (ON B10 B9)
  (ON B11 B10) (ON B13 B11) (ON B16 B13) (ON B18 B16) (ON B20 B18)
  (ON B24 B20) (ON B26 B24) (CLEAR B26) (ON-TABLE B15) (ON B19 B15)
  (ON B21 B19) (ON B31 B21) (CLEAR B31) (ON-TABLE B23) (ON B28 B23)
  (ON B37 B28) (ON B39 B37) (CLEAR B39) (ON-TABLE B27) (CLEAR B27)
  (ON-TABLE B29) (ON B35 B29) (ON B38 B35) (CLEAR B38) (ON-TABLE B32)
  (ON B34 B32) (CLEAR B34))
 ((ON-TABLE B1) (ON B5 B1) (ON B8 B5) (ON B9 B8) (ON B23 B9)
  (ON B24 B23) (ON B28 B24) (ON B33 B28) (ON B38 B33) (CLEAR B38)
  (ON-TABLE B2) (ON B3 B2) (ON B15 B3) (ON B30 B15) (CLEAR B30)
  (ON-TABLE B4) (ON B6 B4) (ON B7 B6) (ON B12 B7) (ON B17 B12)
  (ON B20 B17) (ON B25 B20) (CLEAR B25) (ON-TABLE B10) (ON B22 B10)
  (ON B27 B22) (ON B36 B27) (CLEAR B36) (ON-TABLE B11) (ON B26 B11)
  (ON B37 B26) (CLEAR B37) (ON-TABLE B13) (ON B14 B13) (ON B18 B14)
  (ON B19 B18) (ON B29 B19) (CLEAR B29) (ON-TABLE B16) (ON B21 B16)
  (ON B31 B21) (ON B34 B31) (CLEAR B34) (ON-TABLE B32) (ON B35 B32)
  (CLEAR B35) (ON-TABLE B39) (ON B40 B39) (CLEAR B40)))