(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_19 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B9 B4) (ON B15 B9) (ON B24 B15)
  (ON B27 B24) (ON B38 B27) (CLEAR B38) (ON-TABLE B5) (ON B13 B5)
  (ON B17 B13) (ON B26 B17) (ON B28 B26) (ON B30 B28) (ON B33 B30)
  (ON B40 B33) (CLEAR B40) (ON-TABLE B6) (ON B11 B6) (ON B14 B11)
  (ON B18 B14) (ON B39 B18) (CLEAR B39) (ON-TABLE B7) (ON B8 B7)
  (ON B10 B8) (ON B25 B10) (ON B29 B25) (ON B32 B29) (CLEAR B32)
  (ON-TABLE B12) (ON B22 B12) (ON B31 B22) (ON B34 B31) (CLEAR B34)
  (ON-TABLE B16) (ON B19 B16) (ON B20 B19) (ON B21 B20) (ON B23 B21)
  (ON B35 B23) (ON B36 B35) (ON B37 B36) (CLEAR B37))
 ((ON-TABLE B1) (ON B2 B1) (ON B5 B2) (ON B9 B5) (ON B11 B9)
  (ON B12 B11) (ON B19 B12) (ON B20 B19) (ON B31 B20) (ON B39 B31)
  (CLEAR B39) (ON-TABLE B3) (ON B6 B3) (ON B8 B6) (ON B18 B8)
  (ON B22 B18) (ON B32 B22) (ON B33 B32) (CLEAR B33) (ON-TABLE B4)
  (ON B7 B4) (ON B10 B7) (ON B14 B10) (ON B15 B14) (ON B16 B15)
  (ON B21 B16) (ON B24 B21) (ON B27 B24) (ON B28 B27) (ON B36 B28)
  (ON B37 B36) (ON B38 B37) (CLEAR B38) (ON-TABLE B13) (ON B26 B13)
  (ON B40 B26) (CLEAR B40) (ON-TABLE B17) (ON B23 B17) (ON B29 B23)
  (ON B34 B29) (CLEAR B34) (ON-TABLE B25) (CLEAR B25) (ON-TABLE B30)
  (ON B35 B30) (CLEAR B35)))