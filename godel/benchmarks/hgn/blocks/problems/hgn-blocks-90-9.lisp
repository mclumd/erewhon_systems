(IN-PACKAGE SHOP2) 
(DEFPROBLEM P90_9 BLOCKS-HTN
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
  (BLOCK B77) (BLOCK B78) (BLOCK B79) (BLOCK B80) (BLOCK B81)
  (BLOCK B82) (BLOCK B83) (BLOCK B84) (BLOCK B85) (BLOCK B86)
  (BLOCK B87) (BLOCK B88) (BLOCK B89) (BLOCK B90) (ON-TABLE B1)
  (ON B2 B1) (ON B3 B2) (ON B4 B3) (ON B9 B4) (ON B15 B9) (ON B24 B15)
  (ON B27 B24) (ON B38 B27) (ON B43 B38) (ON B45 B43) (ON B48 B45)
  (ON B52 B48) (ON B56 B52) (ON B71 B56) (ON B79 B71) (CLEAR B79)
  (ON-TABLE B5) (ON B13 B5) (ON B17 B13) (ON B26 B17) (ON B28 B26)
  (ON B30 B28) (ON B33 B30) (ON B40 B33) (ON B41 B40) (ON B42 B41)
  (ON B49 B42) (ON B60 B49) (ON B72 B60) (ON B73 B72) (ON B81 B73)
  (ON B82 B81) (CLEAR B82) (ON-TABLE B6) (ON B11 B6) (ON B14 B11)
  (ON B18 B14) (ON B39 B18) (ON B44 B39) (ON B53 B44) (ON B55 B53)
  (ON B59 B55) (ON B67 B59) (ON B68 B67) (ON B76 B68) (ON B77 B76)
  (ON B78 B77) (ON B90 B78) (CLEAR B90) (ON-TABLE B7) (ON B8 B7)
  (ON B10 B8) (ON B25 B10) (ON B29 B25) (ON B32 B29) (ON B54 B32)
  (ON B57 B54) (ON B58 B57) (ON B61 B58) (ON B65 B61) (ON B66 B65)
  (ON B80 B66) (ON B87 B80) (ON B88 B87) (CLEAR B88) (ON-TABLE B12)
  (ON B22 B12) (ON B31 B22) (ON B34 B31) (ON B50 B34) (ON B51 B50)
  (ON B69 B51) (ON B74 B69) (ON B85 B74) (CLEAR B85) (ON-TABLE B16)
  (ON B19 B16) (ON B20 B19) (ON B21 B20) (ON B23 B21) (ON B35 B23)
  (ON B36 B35) (ON B37 B36) (ON B46 B37) (ON B47 B46) (ON B62 B47)
  (ON B63 B62) (ON B64 B63) (ON B83 B64) (CLEAR B83) (ON-TABLE B70)
  (ON B75 B70) (ON B84 B75) (CLEAR B84) (ON-TABLE B86) (ON B89 B86)
  (CLEAR B89))
 ((ON-TABLE B1) (ON B2 B1) (ON B14 B2) (ON B29 B14) (ON B37 B29)
  (ON B39 B37) (ON B54 B39) (ON B56 B54) (ON B65 B56) (ON B81 B65)
  (ON B90 B81) (CLEAR B90) (ON-TABLE B3) (ON B4 B3) (ON B9 B4)
  (ON B10 B9) (ON B11 B10) (ON B13 B11) (ON B23 B13) (ON B42 B23)
  (ON B45 B42) (ON B63 B45) (ON B72 B63) (ON B88 B72) (CLEAR B88)
  (ON-TABLE B5) (ON B7 B5) (ON B12 B7) (ON B31 B12) (ON B36 B31)
  (ON B43 B36) (ON B50 B43) (ON B69 B50) (CLEAR B69) (ON-TABLE B6)
  (ON B32 B6) (ON B34 B32) (ON B55 B34) (ON B71 B55) (CLEAR B71)
  (ON-TABLE B8) (ON B22 B8) (ON B33 B22) (ON B35 B33) (ON B49 B35)
  (ON B60 B49) (ON B87 B60) (ON B89 B87) (CLEAR B89) (ON-TABLE B15)
  (ON B16 B15) (ON B19 B16) (ON B21 B19) (ON B24 B21) (ON B30 B24)
  (ON B44 B30) (ON B47 B44) (ON B58 B47) (ON B62 B58) (ON B64 B62)
  (ON B73 B64) (ON B82 B73) (CLEAR B82) (ON-TABLE B17) (ON B40 B17)
  (ON B46 B40) (ON B80 B46) (CLEAR B80) (ON-TABLE B18) (ON B27 B18)
  (ON B67 B27) (ON B70 B67) (ON B77 B70) (CLEAR B77) (ON-TABLE B20)
  (ON B26 B20) (ON B28 B26) (ON B51 B28) (ON B52 B51) (ON B61 B52)
  (CLEAR B61) (ON-TABLE B25) (ON B38 B25) (ON B41 B38) (ON B53 B41)
  (ON B59 B53) (ON B75 B59) (ON B85 B75) (CLEAR B85) (ON-TABLE B48)
  (ON B57 B48) (ON B76 B57) (ON B83 B76) (CLEAR B83) (ON-TABLE B66)
  (ON B68 B66) (ON B86 B68) (CLEAR B86) (ON-TABLE B74) (ON B84 B74)
  (CLEAR B84) (ON-TABLE B78) (ON B79 B78) (CLEAR B79)))