(IN-PACKAGE SHOP2) 
(DEFPROBLEM P10_11 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (CLEAR B5) (ON-TABLE B6)
  (ON B8 B6) (ON B9 B8) (CLEAR B9) (ON-TABLE B7) (ON B10 B7)
  (CLEAR B10))
 ((ON-TABLE B1) (CLEAR B1) (ON-TABLE B2) (ON B3 B2) (ON B4 B3)
  (ON B6 B4) (CLEAR B6) (ON-TABLE B5) (ON B7 B5) (ON B8 B7) (CLEAR B8)
  (ON-TABLE B9) (ON B10 B9) (CLEAR B10)))