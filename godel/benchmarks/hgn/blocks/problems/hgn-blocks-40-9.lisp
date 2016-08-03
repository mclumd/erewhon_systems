(IN-PACKAGE SHOP2) 
(DEFPROBLEM P40_9 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (ON-TABLE B1)
  (ON B2 B1) (ON B13 B2) (ON B23 B13) (CLEAR B23) (ON-TABLE B3)
  (ON B6 B3) (ON B8 B6) (ON B17 B8) (ON B27 B17) (ON B33 B27)
  (ON B34 B33) (ON B37 B34) (CLEAR B37) (ON-TABLE B4) (ON B10 B4)
  (ON B22 B10) (CLEAR B22) (ON-TABLE B5) (ON B7 B5) (ON B9 B7)
  (ON B14 B9) (ON B18 B14) (ON B28 B18) (CLEAR B28) (ON-TABLE B11)
  (ON B12 B11) (ON B24 B12) (ON B40 B24) (CLEAR B40) (ON-TABLE B15)
  (ON B19 B15) (ON B21 B19) (ON B31 B21) (ON B39 B31) (CLEAR B39)
  (ON-TABLE B16) (CLEAR B16) (ON-TABLE B20) (ON B25 B20) (ON B30 B25)
  (ON B32 B30) (ON B35 B32) (CLEAR B35) (ON-TABLE B26) (ON B29 B26)
  (CLEAR B29) (ON-TABLE B36) (ON B38 B36) (CLEAR B38))
 ((ON-TABLE B1) (ON B10 B1) (ON B18 B10) (ON B33 B18) (CLEAR B33)
  (ON-TABLE B2) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B12 B5)
  (ON B19 B12) (ON B27 B19) (ON B28 B27) (ON B32 B28) (ON B37 B32)
  (CLEAR B37) (ON-TABLE B6) (ON B7 B6) (ON B9 B7) (ON B13 B9)
  (ON B23 B13) (CLEAR B23) (ON-TABLE B8) (ON B11 B8) (ON B21 B11)
  (ON B22 B21) (ON B24 B22) (ON B31 B24) (CLEAR B31) (ON-TABLE B14)
  (ON B15 B14) (ON B16 B15) (ON B17 B16) (ON B20 B17) (ON B35 B20)
  (ON B36 B35) (ON B38 B36) (CLEAR B38) (ON-TABLE B25) (CLEAR B25)
  (ON-TABLE B26) (ON B34 B26) (ON B40 B34) (CLEAR B40) (ON-TABLE B29)
  (ON B39 B29) (CLEAR B39) (ON-TABLE B30) (CLEAR B30)))