(IN-PACKAGE SHOP2) 
(DEFPROBLEM P20_7 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (ON-TABLE B1)
  (ON B3 B1) (ON B19 B3) (CLEAR B19) (ON-TABLE B2) (ON B8 B2)
  (ON B9 B8) (ON B18 B9) (CLEAR B18) (ON-TABLE B4) (ON B5 B4)
  (ON B6 B5) (ON B7 B6) (ON B10 B7) (ON B13 B10) (ON B15 B13)
  (ON B16 B15) (ON B17 B16) (CLEAR B17) (ON-TABLE B11) (ON B12 B11)
  (CLEAR B12) (ON-TABLE B14) (CLEAR B14) (ON-TABLE B20) (CLEAR B20))
 ((ON-TABLE B1) (ON B10 B1) (ON B13 B10) (CLEAR B13) (ON-TABLE B2)
  (ON B3 B2) (ON B4 B3) (ON B7 B4) (ON B16 B7) (ON B17 B16) (CLEAR B17)
  (ON-TABLE B5) (ON B8 B5) (ON B19 B8) (CLEAR B19) (ON-TABLE B6)
  (ON B12 B6) (ON B18 B12) (ON B20 B18) (CLEAR B20) (ON-TABLE B9)
  (ON B11 B9) (ON B14 B11) (ON B15 B14) (CLEAR B15)))