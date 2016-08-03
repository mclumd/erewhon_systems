(IN-PACKAGE SHOP2) 
(DEFPROBLEM P80_13 BLOCKS-HTN
 ((ARM-EMPTY) (BLOCK B1) (BLOCK B2) (BLOCK B3) (BLOCK B4) (BLOCK B5)
  (BLOCK B6) (BLOCK B7) (BLOCK B8) (BLOCK B9) (BLOCK B10) (BLOCK B11)
  (BLOCK B12) (BLOCK B13) (BLOCK B14) (BLOCK B15) (BLOCK B16)
  (BLOCK B17) (BLOCK B18) (BLOCK B19) (BLOCK B20) (BLOCK B21)
  (BLOCK B22) (BLOCK B23) (BLOCK B24) (BLOCK B25) (BLOCK B26)
  (BLOCK B27) (BLOCK B28) (BLOCK B29) (BLOCK B30) (BLOCK B31)
  (BLOCK B32) (BLOCK B33) (BLOCK B34) (BLOCK B35) (BLOCK B36)
  (BLOCK B37) (BLOCK B38) (BLOCK B39) (BLOCK B40) (BLOCK B41)
  (BLOCK B42) (BLOCK B43) (BLOCK B44) (BLOCK B45) (BLOCK B46)
  (BLOCK B47) (BLOCK B48) (BLOCK B49) (BLOCK B50) (BLOCK B51)
  (BLOCK B52) (BLOCK B53) (BLOCK B54) (BLOCK B55) (BLOCK B56)
  (BLOCK B57) (BLOCK B58) (BLOCK B59) (BLOCK B60) (BLOCK B61)
  (BLOCK B62) (BLOCK B63) (BLOCK B64) (BLOCK B65) (BLOCK B66)
  (BLOCK B67) (BLOCK B68) (BLOCK B69) (BLOCK B70) (BLOCK B71)
  (BLOCK B72) (BLOCK B73) (BLOCK B74) (BLOCK B75) (BLOCK B76)
  (BLOCK B77) (BLOCK B78) (BLOCK B79) (BLOCK B80) (ON-TABLE B1)
  (ON B3 B1) (ON B7 B3) (ON B11 B7) (ON B14 B11) (ON B16 B14)
  (ON B30 B16) (ON B48 B30) (ON B58 B48) (CLEAR B58) (ON-TABLE B2)
  (ON B5 B2) (ON B12 B5) (ON B15 B12) (ON B25 B15) (ON B26 B25)
  (ON B33 B26) (ON B40 B33) (ON B57 B40) (ON B71 B57) (ON B79 B71)
  (CLEAR B79) (ON-TABLE B4) (ON B8 B4) (ON B31 B8) (ON B35 B31)
  (ON B37 B35) (ON B47 B37) (ON B60 B47) (ON B63 B60) (CLEAR B63)
  (ON-TABLE B6) (ON B9 B6) (ON B17 B9) (ON B23 B17) (ON B41 B23)
  (CLEAR B41) (ON-TABLE B10) (ON B13 B10) (ON B18 B13) (ON B19 B18)
  (ON B21 B19) (ON B22 B21) (ON B24 B22) (ON B27 B24) (ON B51 B27)
  (ON B66 B51) (ON B73 B66) (ON B80 B73) (CLEAR B80) (ON-TABLE B20)
  (ON B29 B20) (ON B42 B29) (ON B46 B42) (ON B49 B46) (ON B50 B49)
  (ON B53 B50) (ON B62 B53) (ON B67 B62) (CLEAR B67) (ON-TABLE B28)
  (ON B34 B28) (ON B78 B34) (CLEAR B78) (ON-TABLE B32) (ON B44 B32)
  (CLEAR B44) (ON-TABLE B36) (ON B39 B36) (ON B52 B39) (ON B55 B52)
  (ON B56 B55) (ON B64 B56) (ON B75 B64) (CLEAR B75) (ON-TABLE B38)
  (ON B45 B38) (ON B54 B45) (ON B65 B54) (ON B74 B65) (CLEAR B74)
  (ON-TABLE B43) (ON B68 B43) (ON B77 B68) (CLEAR B77) (ON-TABLE B59)
  (ON B61 B59) (ON B69 B61) (CLEAR B69) (ON-TABLE B70) (ON B72 B70)
  (CLEAR B72) (ON-TABLE B76) (CLEAR B76))
 ((ON-TABLE B1) (ON B4 B1) (ON B24 B4) (ON B26 B24) (ON B28 B26)
  (ON B32 B28) (ON B68 B32) (ON B69 B68) (ON B72 B69) (CLEAR B72)
  (ON-TABLE B2) (ON B5 B2) (ON B7 B5) (ON B15 B7) (ON B16 B15)
  (ON B22 B16) (ON B25 B22) (ON B30 B25) (ON B36 B30) (ON B37 B36)
  (ON B77 B37) (CLEAR B77) (ON-TABLE B3) (ON B6 B3) (ON B9 B6)
  (ON B11 B9) (ON B17 B11) (ON B44 B17) (ON B60 B44) (CLEAR B60)
  (ON-TABLE B8) (ON B19 B8) (ON B39 B19) (ON B47 B39) (ON B54 B47)
  (ON B80 B54) (CLEAR B80) (ON-TABLE B10) (ON B14 B10) (ON B18 B14)
  (ON B21 B18) (ON B45 B21) (ON B65 B45) (ON B74 B65) (CLEAR B74)
  (ON-TABLE B12) (ON B20 B12) (ON B29 B20) (ON B31 B29) (ON B33 B31)
  (ON B46 B33) (ON B52 B46) (CLEAR B52) (ON-TABLE B13) (ON B23 B13)
  (ON B27 B23) (ON B49 B27) (ON B58 B49) (ON B61 B58) (ON B75 B61)
  (ON B79 B75) (CLEAR B79) (ON-TABLE B34) (ON B42 B34) (ON B55 B42)
  (ON B59 B55) (CLEAR B59) (ON-TABLE B35) (ON B38 B35) (ON B41 B38)
  (ON B48 B41) (CLEAR B48) (ON-TABLE B40) (ON B43 B40) (ON B66 B43)
  (ON B71 B66) (CLEAR B71) (ON-TABLE B50) (ON B57 B50) (CLEAR B57)
  (ON-TABLE B51) (ON B70 B51) (ON B76 B70) (CLEAR B76) (ON-TABLE B53)
  (ON B56 B53) (ON B62 B56) (ON B64 B62) (ON B73 B64) (CLEAR B73)
  (ON-TABLE B63) (CLEAR B63) (ON-TABLE B67) (ON B78 B67) (CLEAR B78)))