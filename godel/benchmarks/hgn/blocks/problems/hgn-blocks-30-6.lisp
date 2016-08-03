(IN-PACKAGE SHOP2) 
(DEFPROBLEM P30_6 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (ON-TABLE B1)
  (ON B5 B1) (ON B8 B5) (CLEAR B8) (ON-TABLE B2) (ON B3 B2) (ON B6 B3)
  (ON B9 B6) (ON B13 B9) (ON B15 B13) (ON B16 B15) (ON B17 B16)
  (ON B20 B17) (ON B28 B20) (CLEAR B28) (ON-TABLE B4) (ON B7 B4)
  (ON B14 B7) (ON B23 B14) (ON B26 B23) (CLEAR B26) (ON-TABLE B10)
  (ON B11 B10) (ON B12 B11) (ON B22 B12) (ON B24 B22) (ON B27 B24)
  (CLEAR B27) (ON-TABLE B18) (ON B19 B18) (CLEAR B19) (ON-TABLE B21)
  (ON B25 B21) (CLEAR B25) (ON-TABLE B29) (CLEAR B29) (ON-TABLE B30)
  (CLEAR B30))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B10 B3) (ON B15 B10)
  (CLEAR B15) (ON-TABLE B4) (ON B6 B4) (ON B8 B6) (ON B9 B8)
  (ON B12 B9) (ON B13 B12) (ON B17 B13) (ON B29 B17) (CLEAR B29)
  (ON-TABLE B5) (CLEAR B5) (ON-TABLE B7) (ON B16 B7) (ON B24 B16)
  (ON B25 B24) (CLEAR B25) (ON-TABLE B11) (CLEAR B11) (ON-TABLE B14)
  (ON B23 B14) (ON B26 B23) (ON B30 B26) (CLEAR B30) (ON-TABLE B18)
  (ON B19 B18) (CLEAR B19) (ON-TABLE B20) (ON B21 B20) (CLEAR B21)
  (ON-TABLE B22) (CLEAR B22) (ON-TABLE B27) (ON B28 B27) (CLEAR B28)))