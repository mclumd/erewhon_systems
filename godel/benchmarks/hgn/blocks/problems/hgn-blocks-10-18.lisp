(IN-PACKAGE SHOP2) 
(DEFPROBLEM P10_18 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (ON-TABLE B1)
  (ON B6 B1) (ON B7 B6) (CLEAR B7) (ON-TABLE B2) (ON B3 B2) (ON B8 B3)
  (CLEAR B8) (ON-TABLE B4) (ON B5 B4) (ON B9 B5) (CLEAR B9)
  (ON-TABLE B10) (CLEAR B10))
 ((ON-TABLE B1) (ON B2 B1) (ON B4 B2) (ON B9 B4) (CLEAR B9)
  (ON-TABLE B3) (ON B5 B3) (ON B7 B5) (CLEAR B7) (ON-TABLE B6)
  (CLEAR B6) (ON-TABLE B8) (CLEAR B8) (ON-TABLE B10) (CLEAR B10)))