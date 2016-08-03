(IN-PACKAGE SHOP2) 
(DEFPROBLEM P30_17 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B6 B4) (ON B7 B6) (ON B13 B7)
  (ON B21 B13) (ON B30 B21) (CLEAR B30) (ON-TABLE B5) (ON B8 B5)
  (ON B9 B8) (ON B12 B9) (ON B24 B12) (CLEAR B24) (ON-TABLE B10)
  (ON B15 B10) (ON B18 B15) (ON B19 B18) (ON B25 B19) (CLEAR B25)
  (ON-TABLE B11) (ON B16 B11) (ON B27 B16) (CLEAR B27) (ON-TABLE B14)
  (ON B17 B14) (ON B20 B17) (CLEAR B20) (ON-TABLE B22) (ON B23 B22)
  (CLEAR B23) (ON-TABLE B26) (ON B28 B26) (ON B29 B28) (CLEAR B29))
 ((ON-TABLE B1) (ON B2 B1) (ON B7 B2) (ON B9 B7) (ON B10 B9)
  (ON B12 B10) (ON B14 B12) (ON B16 B14) (ON B20 B16) (ON B23 B20)
  (CLEAR B23) (ON-TABLE B3) (ON B21 B3) (CLEAR B21) (ON-TABLE B4)
  (ON B11 B4) (ON B18 B11) (ON B29 B18) (ON B30 B29) (CLEAR B30)
  (ON-TABLE B5) (ON B6 B5) (ON B8 B6) (ON B17 B8) (ON B22 B17)
  (ON B26 B22) (CLEAR B26) (ON-TABLE B13) (ON B15 B13) (ON B19 B15)
  (CLEAR B19) (ON-TABLE B24) (CLEAR B24) (ON-TABLE B25) (ON B28 B25)
  (CLEAR B28) (ON-TABLE B27) (CLEAR B27)))