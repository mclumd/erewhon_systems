(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_12 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B6 B5) (ON B9 B6)
  (ON B29 B9) (ON B38 B29) (CLEAR B38) (ON-TABLE B7) (ON B11 B7)
  (ON B12 B11) (ON B31 B12) (ON B37 B31) (CLEAR B37) (ON-TABLE B8)
  (ON B10 B8) (ON B14 B10) (ON B17 B14) (ON B18 B17) (ON B21 B18)
  (ON B26 B21) (ON B33 B26) (ON B39 B33) (ON B40 B39) (CLEAR B40)
  (ON-TABLE B13) (ON B15 B13) (ON B16 B15) (ON B19 B16) (ON B20 B19)
  (ON B25 B20) (ON B30 B25) (CLEAR B30) (ON-TABLE B22) (ON B23 B22)
  (ON B32 B23) (ON B34 B32) (ON B35 B34) (CLEAR B35) (ON-TABLE B24)
  (ON B36 B24) (CLEAR B36) (ON-TABLE B27) (ON B28 B27) (CLEAR B28))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B5 B3) (ON B7 B5) (ON B12 B7)
  (ON B14 B12) (ON B15 B14) (ON B25 B15) (ON B26 B25) (ON B27 B26)
  (ON B33 B27) (CLEAR B33) (ON-TABLE B4) (ON B11 B4) (ON B24 B11)
  (ON B35 B24) (CLEAR B35) (ON-TABLE B6) (ON B8 B6) (ON B9 B8)
  (ON B17 B9) (ON B23 B17) (CLEAR B23) (ON-TABLE B10) (ON B16 B10)
  (ON B21 B16) (ON B22 B21) (ON B36 B22) (CLEAR B36) (ON-TABLE B13)
  (ON B18 B13) (ON B19 B18) (CLEAR B19) (ON-TABLE B20) (ON B34 B20)
  (CLEAR B34) (ON-TABLE B28) (ON B39 B28) (CLEAR B39) (ON-TABLE B29)
  (ON B32 B29) (ON B37 B32) (CLEAR B37) (ON-TABLE B30) (ON B31 B30)
  (ON B38 B31) (ON B40 B38) (CLEAR B40)))