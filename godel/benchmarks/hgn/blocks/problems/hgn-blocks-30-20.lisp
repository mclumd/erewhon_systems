(IN-PACKAGE SHOP2) 
(DEFPROBLEM P30_20 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (ON-TABLE B1)
  (ON B2 B1) (ON B27 B2) (ON B28 B27) (CLEAR B28) (ON-TABLE B3)
  (ON B8 B3) (ON B12 B8) (ON B13 B12) (ON B20 B13) (ON B23 B20)
  (ON B24 B23) (CLEAR B24) (ON-TABLE B4) (ON B5 B4) (ON B9 B5)
  (ON B11 B9) (ON B14 B11) (ON B15 B14) (ON B25 B15) (ON B30 B25)
  (CLEAR B30) (ON-TABLE B6) (ON B18 B6) (CLEAR B18) (ON-TABLE B7)
  (ON B10 B7) (ON B17 B10) (ON B22 B17) (ON B29 B22) (CLEAR B29)
  (ON-TABLE B16) (ON B19 B16) (ON B26 B19) (CLEAR B26) (ON-TABLE B21)
  (CLEAR B21))
 ((ON-TABLE B1) (ON B2 B1) (ON B5 B2) (ON B6 B5) (ON B27 B6)
  (CLEAR B27) (ON-TABLE B3) (ON B11 B3) (ON B12 B11) (ON B22 B12)
  (ON B26 B22) (CLEAR B26) (ON-TABLE B4) (ON B10 B4) (ON B20 B10)
  (ON B24 B20) (ON B25 B24) (ON B29 B25) (CLEAR B29) (ON-TABLE B7)
  (ON B8 B7) (ON B14 B8) (ON B19 B14) (ON B28 B19) (CLEAR B28)
  (ON-TABLE B9) (ON B13 B9) (ON B15 B13) (ON B18 B15) (CLEAR B18)
  (ON-TABLE B16) (ON B17 B16) (ON B21 B17) (ON B30 B21) (CLEAR B30)
  (ON-TABLE B23) (CLEAR B23)))