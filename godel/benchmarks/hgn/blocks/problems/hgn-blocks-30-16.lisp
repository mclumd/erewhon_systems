(IN-PACKAGE SHOP2) 
(DEFPROBLEM P30_16 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B6 B3) (ON B7 B6) (ON B9 B7) (ON B11 B9)
  (ON B12 B11) (ON B14 B12) (ON B15 B14) (ON B18 B15) (ON B19 B18)
  (ON B27 B19) (CLEAR B27) (ON-TABLE B4) (ON B5 B4) (ON B16 B5)
  (ON B17 B16) (ON B22 B17) (ON B25 B22) (CLEAR B25) (ON-TABLE B8)
  (ON B13 B8) (ON B20 B13) (ON B21 B20) (ON B28 B21) (CLEAR B28)
  (ON-TABLE B10) (ON B30 B10) (CLEAR B30) (ON-TABLE B23) (CLEAR B23)
  (ON-TABLE B24) (CLEAR B24) (ON-TABLE B26) (ON B29 B26) (CLEAR B29))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B8 B5)
  (ON B23 B8) (CLEAR B23) (ON-TABLE B6) (ON B13 B6) (ON B25 B13)
  (CLEAR B25) (ON-TABLE B7) (ON B9 B7) (ON B14 B9) (CLEAR B14)
  (ON-TABLE B10) (ON B15 B10) (ON B26 B15) (CLEAR B26) (ON-TABLE B11)
  (ON B12 B11) (ON B16 B12) (CLEAR B16) (ON-TABLE B17) (ON B24 B17)
  (CLEAR B24) (ON-TABLE B18) (ON B29 B18) (CLEAR B29) (ON-TABLE B19)
  (ON B22 B19) (ON B27 B22) (CLEAR B27) (ON-TABLE B20) (ON B21 B20)
  (ON B28 B21) (ON B30 B28) (CLEAR B30)))