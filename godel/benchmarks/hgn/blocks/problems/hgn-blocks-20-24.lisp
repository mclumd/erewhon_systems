(IN-PACKAGE SHOP2) 
(DEFPROBLEM P20_24 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B5 B3) (ON B7 B5) (ON B12 B7) (ON B14 B12)
  (ON B15 B14) (CLEAR B15) (ON-TABLE B4) (ON B11 B4) (CLEAR B11)
  (ON-TABLE B6) (ON B8 B6) (ON B9 B8) (ON B17 B9) (CLEAR B17)
  (ON-TABLE B10) (ON B16 B10) (CLEAR B16) (ON-TABLE B13) (ON B18 B13)
  (ON B19 B18) (CLEAR B19) (ON-TABLE B20) (CLEAR B20))
 ((ON-TABLE B1) (ON B2 B1) (ON B8 B2) (ON B13 B8) (ON B14 B13)
  (CLEAR B14) (ON-TABLE B3) (ON B5 B3) (ON B15 B5) (ON B19 B15)
  (CLEAR B19) (ON-TABLE B4) (ON B6 B4) (ON B9 B6) (ON B10 B9)
  (ON B12 B10) (ON B17 B12) (CLEAR B17) (ON-TABLE B7) (ON B11 B7)
  (ON B16 B11) (ON B18 B16) (ON B20 B18) (CLEAR B20)))