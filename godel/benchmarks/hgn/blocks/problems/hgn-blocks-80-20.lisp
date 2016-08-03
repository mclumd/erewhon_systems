(IN-PACKAGE SHOP2) 
(DEFPROBLEM P80_20 BLOCKS-HTN
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
  (ON B2 B1) (ON B4 B2) (ON B21 B4) (ON B24 B21) (ON B39 B24)
  (ON B40 B39) (ON B46 B40) (ON B67 B46) (CLEAR B67) (ON-TABLE B3)
  (ON B5 B3) (ON B7 B5) (ON B11 B7) (ON B16 B11) (ON B19 B16)
  (ON B22 B19) (ON B29 B22) (ON B36 B29) (ON B51 B36) (CLEAR B51)
  (ON-TABLE B6) (ON B8 B6) (ON B14 B8) (ON B17 B14) (ON B20 B17)
  (ON B25 B20) (ON B28 B25) (ON B34 B28) (ON B44 B34) (ON B75 B44)
  (CLEAR B75) (ON-TABLE B9) (ON B10 B9) (ON B12 B10) (ON B13 B12)
  (ON B18 B13) (ON B26 B18) (ON B35 B26) (ON B45 B35) (ON B58 B45)
  (ON B68 B58) (ON B72 B68) (CLEAR B72) (ON-TABLE B15) (ON B31 B15)
  (ON B33 B31) (ON B37 B33) (ON B48 B37) (ON B63 B48) (ON B65 B63)
  (ON B73 B65) (ON B74 B73) (ON B76 B74) (CLEAR B76) (ON-TABLE B23)
  (ON B27 B23) (ON B32 B27) (ON B42 B32) (ON B43 B42) (ON B52 B43)
  (ON B54 B52) (ON B57 B54) (ON B66 B57) (ON B71 B66) (ON B78 B71)
  (CLEAR B78) (ON-TABLE B30) (ON B38 B30) (ON B53 B38) (CLEAR B53)
  (ON-TABLE B41) (ON B55 B41) (ON B59 B55) (ON B60 B59) (ON B70 B60)
  (CLEAR B70) (ON-TABLE B47) (ON B49 B47) (ON B50 B49) (ON B56 B50)
  (ON B79 B56) (CLEAR B79) (ON-TABLE B61) (ON B62 B61) (ON B64 B62)
  (ON B69 B64) (CLEAR B69) (ON-TABLE B77) (CLEAR B77) (ON-TABLE B80)
  (CLEAR B80))
 ((ON-TABLE B1) (ON B2 B1) (ON B4 B2) (ON B5 B4) (ON B10 B5)
  (ON B11 B10) (ON B12 B11) (ON B14 B12) (ON B18 B14) (ON B21 B18)
  (ON B26 B21) (ON B41 B26) (ON B53 B41) (ON B58 B53) (ON B75 B58)
  (CLEAR B75) (ON-TABLE B3) (ON B16 B3) (ON B22 B16) (ON B25 B22)
  (ON B30 B25) (ON B39 B30) (ON B46 B39) (ON B60 B46) (ON B72 B60)
  (ON B73 B72) (CLEAR B73) (ON-TABLE B6) (ON B8 B6) (ON B9 B8)
  (ON B17 B9) (ON B20 B17) (ON B24 B20) (ON B32 B24) (ON B48 B32)
  (ON B59 B48) (ON B67 B59) (ON B68 B67) (ON B71 B68) (ON B79 B71)
  (CLEAR B79) (ON-TABLE B7) (ON B27 B7) (ON B29 B27) (ON B51 B29)
  (CLEAR B51) (ON-TABLE B13) (ON B15 B13) (ON B31 B15) (ON B52 B31)
  (ON B54 B52) (ON B64 B54) (ON B69 B64) (ON B74 B69) (ON B77 B74)
  (ON B80 B77) (CLEAR B80) (ON-TABLE B19) (ON B23 B19) (ON B37 B23)
  (ON B38 B37) (ON B40 B38) (CLEAR B40) (ON-TABLE B28) (ON B35 B28)
  (ON B36 B35) (ON B42 B36) (ON B44 B42) (ON B47 B44) (ON B55 B47)
  (ON B56 B55) (ON B61 B56) (CLEAR B61) (ON-TABLE B33) (ON B34 B33)
  (ON B45 B34) (CLEAR B45) (ON-TABLE B43) (ON B63 B43) (ON B70 B63)
  (CLEAR B70) (ON-TABLE B49) (ON B50 B49) (ON B57 B50) (ON B76 B57)
  (ON B78 B76) (CLEAR B78) (ON-TABLE B62) (ON B65 B62) (ON B66 B65)
  (CLEAR B66)))