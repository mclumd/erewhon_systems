(IN-PACKAGE SHOP2) 
(DEFPROBLEM P30_12 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (ON-TABLE B1)
  (ON B2 B1) (ON B11 B2) (ON B18 B11) (CLEAR B18) (ON-TABLE B3)
  (ON B4 B3) (ON B5 B4) (ON B13 B5) (ON B14 B13) (ON B21 B14)
  (ON B25 B21) (CLEAR B25) (ON-TABLE B6) (ON B10 B6) (ON B12 B10)
  (ON B15 B12) (ON B24 B15) (ON B29 B24) (CLEAR B29) (ON-TABLE B7)
  (ON B8 B7) (ON B9 B8) (ON B17 B9) (ON B28 B17) (CLEAR B28)
  (ON-TABLE B16) (ON B30 B16) (CLEAR B30) (ON-TABLE B19) (ON B22 B19)
  (CLEAR B22) (ON-TABLE B20) (ON B23 B20) (ON B26 B23) (ON B27 B26)
  (CLEAR B27))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B8 B3) (ON B11 B8)
  (ON B12 B11) (ON B15 B12) (ON B16 B15) (ON B18 B16) (ON B25 B18)
  (CLEAR B25) (ON-TABLE B4) (ON B5 B4) (ON B6 B5) (ON B7 B6) (ON B9 B7)
  (ON B10 B9) (ON B24 B10) (ON B29 B24) (CLEAR B29) (ON-TABLE B13)
  (ON B20 B13) (ON B30 B20) (CLEAR B30) (ON-TABLE B14) (ON B17 B14)
  (ON B21 B17) (CLEAR B21) (ON-TABLE B19) (ON B23 B19) (ON B26 B23)
  (ON B28 B26) (CLEAR B28) (ON-TABLE B22) (CLEAR B22) (ON-TABLE B27)
  (CLEAR B27)))