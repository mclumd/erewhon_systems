(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_21 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B10 B1) (ON B11 B10) (ON B19 B11) (ON B21 B19) (ON B28 B21)
  (ON B29 B28) (ON B32 B29) (CLEAR B32) (ON-TABLE B2) (ON B5 B2)
  (ON B9 B5) (ON B13 B9) (ON B22 B13) (ON B36 B22) (ON B39 B36)
  (CLEAR B39) (ON-TABLE B3) (ON B4 B3) (ON B6 B4) (ON B12 B6)
  (ON B17 B12) (ON B23 B17) (ON B40 B23) (CLEAR B40) (ON-TABLE B7)
  (ON B14 B7) (ON B15 B14) (CLEAR B15) (ON-TABLE B8) (ON B20 B8)
  (ON B30 B20) (ON B31 B30) (CLEAR B31) (ON-TABLE B16) (ON B25 B16)
  (ON B27 B25) (CLEAR B27) (ON-TABLE B18) (ON B26 B18) (ON B38 B26)
  (CLEAR B38) (ON-TABLE B24) (ON B34 B24) (CLEAR B34) (ON-TABLE B33)
  (ON B35 B33) (ON B37 B35) (CLEAR B37))
 ((ON-TABLE B1) (ON B3 B1) (ON B5 B3) (ON B15 B5) (ON B25 B15)
  (CLEAR B25) (ON-TABLE B2) (ON B4 B2) (ON B6 B4) (ON B10 B6)
  (ON B12 B10) (ON B13 B12) (ON B16 B13) (ON B28 B16) (ON B30 B28)
  (ON B39 B30) (CLEAR B39) (ON-TABLE B7) (ON B8 B7) (ON B21 B8)
  (ON B23 B21) (ON B26 B23) (ON B37 B26) (ON B40 B37) (CLEAR B40)
  (ON-TABLE B9) (ON B32 B9) (ON B38 B32) (CLEAR B38) (ON-TABLE B11)
  (ON B18 B11) (ON B22 B18) (ON B31 B22) (CLEAR B31) (ON-TABLE B14)
  (ON B17 B14) (ON B24 B17) (ON B34 B24) (CLEAR B34) (ON-TABLE B19)
  (ON B20 B19) (ON B29 B20) (ON B35 B29) (ON B36 B35) (CLEAR B36)
  (ON-TABLE B27) (ON B33 B27) (CLEAR B33)))