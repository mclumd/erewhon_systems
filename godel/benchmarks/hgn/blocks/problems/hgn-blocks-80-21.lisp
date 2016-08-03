(IN-PACKAGE SHOP2) 
(DEFPROBLEM P80_21 BLOCKS-HTN
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
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B9 B4) (ON B29 B9) (ON B37 B29)
  (ON B47 B37) (ON B48 B47) (ON B65 B48) (ON B71 B65) (CLEAR B71)
  (ON-TABLE B5) (ON B6 B5) (ON B19 B6) (ON B22 B19) (ON B23 B22)
  (ON B36 B23) (ON B54 B36) (ON B55 B54) (ON B79 B55) (CLEAR B79)
  (ON-TABLE B7) (ON B10 B7) (ON B14 B10) (ON B17 B14) (ON B30 B17)
  (ON B32 B30) (ON B45 B32) (ON B53 B45) (ON B64 B53) (ON B69 B64)
  (CLEAR B69) (ON-TABLE B8) (ON B16 B8) (ON B20 B16) (ON B21 B20)
  (ON B24 B21) (ON B27 B24) (ON B33 B27) (ON B38 B33) (ON B41 B38)
  (ON B43 B41) (ON B52 B43) (ON B70 B52) (CLEAR B70) (ON-TABLE B11)
  (ON B12 B11) (ON B13 B12) (ON B15 B13) (ON B25 B15) (ON B31 B25)
  (ON B50 B31) (ON B72 B50) (CLEAR B72) (ON-TABLE B18) (ON B39 B18)
  (ON B58 B39) (ON B67 B58) (ON B78 B67) (CLEAR B78) (ON-TABLE B26)
  (ON B28 B26) (ON B80 B28) (CLEAR B80) (ON-TABLE B34) (ON B42 B34)
  (ON B46 B42) (ON B63 B46) (ON B66 B63) (CLEAR B66) (ON-TABLE B35)
  (ON B40 B35) (ON B49 B40) (ON B56 B49) (ON B57 B56) (ON B73 B57)
  (CLEAR B73) (ON-TABLE B44) (ON B61 B44) (ON B74 B61) (CLEAR B74)
  (ON-TABLE B51) (ON B75 B51) (CLEAR B75) (ON-TABLE B59) (ON B60 B59)
  (ON B68 B60) (CLEAR B68) (ON-TABLE B62) (ON B76 B62) (ON B77 B76)
  (CLEAR B77))
 ((ON-TABLE B1) (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B5 B4) (ON B6 B5)
  (ON B8 B6) (ON B22 B8) (ON B25 B22) (ON B28 B25) (ON B53 B28)
  (ON B62 B53) (ON B64 B62) (CLEAR B64) (ON-TABLE B7) (ON B9 B7)
  (ON B10 B9) (ON B11 B10) (ON B13 B11) (ON B14 B13) (ON B15 B14)
  (ON B21 B15) (ON B26 B21) (ON B31 B26) (ON B39 B31) (ON B52 B39)
  (ON B67 B52) (ON B72 B67) (CLEAR B72) (ON-TABLE B12) (ON B16 B12)
  (ON B18 B16) (ON B19 B18) (ON B24 B19) (ON B38 B24) (ON B40 B38)
  (ON B58 B40) (ON B76 B58) (ON B77 B76) (CLEAR B77) (ON-TABLE B17)
  (ON B20 B17) (ON B30 B20) (ON B34 B30) (ON B43 B34) (ON B47 B43)
  (ON B59 B47) (ON B60 B59) (ON B70 B60) (CLEAR B70) (ON-TABLE B23)
  (ON B54 B23) (ON B61 B54) (ON B63 B61) (ON B80 B63) (CLEAR B80)
  (ON-TABLE B27) (CLEAR B27) (ON-TABLE B29) (ON B37 B29) (ON B68 B37)
  (CLEAR B68) (ON-TABLE B32) (ON B33 B32) (ON B51 B33) (ON B65 B51)
  (ON B75 B65) (CLEAR B75) (ON-TABLE B35) (ON B36 B35) (ON B48 B36)
  (ON B78 B48) (CLEAR B78) (ON-TABLE B41) (ON B42 B41) (ON B46 B42)
  (ON B57 B46) (ON B69 B57) (ON B71 B69) (CLEAR B71) (ON-TABLE B44)
  (ON B50 B44) (ON B73 B50) (CLEAR B73) (ON-TABLE B45) (CLEAR B45)
  (ON-TABLE B49) (ON B55 B49) (CLEAR B55) (ON-TABLE B56) (ON B74 B56)
  (CLEAR B74) (ON-TABLE B66) (CLEAR B66) (ON-TABLE B79) (CLEAR B79)))