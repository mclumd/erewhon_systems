(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_23 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B4 B1) (ON B13 B4) (ON B19 B13) (ON B21 B19) (ON B25 B21)
  (ON B40 B25) (CLEAR B40) (ON-TABLE B2) (ON B3 B2) (ON B5 B3)
  (ON B6 B5) (ON B15 B6) (ON B17 B15) (ON B18 B17) (ON B28 B18)
  (ON B32 B28) (ON B33 B32) (ON B36 B33) (ON B38 B36) (ON B39 B38)
  (CLEAR B39) (ON-TABLE B7) (ON B8 B7) (ON B9 B8) (ON B27 B9)
  (ON B30 B27) (CLEAR B30) (ON-TABLE B10) (ON B14 B10) (ON B20 B14)
  (ON B24 B20) (CLEAR B24) (ON-TABLE B11) (ON B12 B11) (ON B16 B12)
  (ON B22 B16) (ON B23 B22) (ON B26 B23) (ON B29 B26) (CLEAR B29)
  (ON-TABLE B31) (ON B34 B31) (ON B35 B34) (CLEAR B35) (ON-TABLE B37)
  (CLEAR B37))
 ((ON-TABLE B1) (ON B3 B1) (ON B6 B3) (ON B7 B6) (ON B9 B7) (ON B20 B9)
  (ON B22 B20) (ON B26 B22) (ON B31 B26) (ON B40 B31) (CLEAR B40)
  (ON-TABLE B2) (ON B5 B2) (ON B8 B5) (ON B10 B8) (ON B11 B10)
  (ON B15 B11) (ON B17 B15) (ON B35 B17) (ON B37 B35) (CLEAR B37)
  (ON-TABLE B4) (ON B16 B4) (ON B28 B16) (ON B29 B28) (ON B34 B29)
  (ON B39 B34) (CLEAR B39) (ON-TABLE B12) (ON B25 B12) (ON B38 B25)
  (CLEAR B38) (ON-TABLE B13) (ON B14 B13) (ON B18 B14) (ON B19 B18)
  (CLEAR B19) (ON-TABLE B21) (ON B27 B21) (ON B36 B27) (CLEAR B36)
  (ON-TABLE B23) (ON B24 B23) (ON B32 B24) (ON B33 B32) (CLEAR B33)
  (ON-TABLE B30) (CLEAR B30)))