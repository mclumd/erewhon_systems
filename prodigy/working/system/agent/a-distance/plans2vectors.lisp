(in-package :user)

;;;; 
;;;; File plan2vectors.lisp implements the functions to map Kerkez's plan 
;;;; representation into state vector sequences for use in the A-distance 
;;;; metric. Read the file README.
;;;; 

#|

;;; Soln to p1 in problems generated for the logistics domain.

((NULL)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD PO_CI) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (DRIVE-TRUCK T_CI AIRPORT_CI PO_CI)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD PO_CI) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CI PO_CI) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE) (AT-TRUCK T_CD AIRPORT_CD)
  (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (LOAD-TRUCK OBJD T_CI PO_CI)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJD T_CI)
  (INSIDE-TRUCK OBJC T_CA) (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CI PO_CI) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE) (AT-TRUCK T_CD AIRPORT_CD)
  (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (DRIVE-TRUCK T_CI PO_CI AIRPORT_CI)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJD T_CI)
  (INSIDE-TRUCK OBJC T_CA) (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (UNLOAD-TRUCK OBJD T_CI AIRPORT_CI)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD AIRPORT_CI) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (LOAD-AIRPLANE OBJD PLANEB AIRPORT_CI)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJD PLANEB) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANED AIRPORT_CJ) (AT-AIRPLANE PLANEA AIRPORT_CB)
  (AT-AIRPLANE PLANEB AIRPORT_CI) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (FLY-AIRPLANE PLANEB AIRPORT_CI AIRPORT_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJD PLANEB) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (UNLOAD-AIRPLANE OBJD PLANEB AIRPORT_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD AIRPORT_CG) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (DRIVE-TRUCK T_CG PO_CG AIRPORT_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD AIRPORT_CG) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CG AIRPORT_CG)
  (AT-TRUCK T_CJ AIRPORT_CJ) (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (LOAD-TRUCK OBJD T_CG AIRPORT_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJD T_CG)
  (INSIDE-TRUCK OBJC T_CA) (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CG AIRPORT_CG)
  (AT-TRUCK T_CJ AIRPORT_CJ) (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (DRIVE-TRUCK T_CG AIRPORT_CG PO_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJD T_CG)
  (INSIDE-TRUCK OBJC T_CA) (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA))
 (UNLOAD-TRUCK OBJD T_CG PO_CG)
 ((SAME-CITY PO_CJ AIRPORT_CJ) (SAME-CITY AIRPORT_CJ PO_CJ) (SAME-CITY PO_CI AIRPORT_CI) (SAME-CITY AIRPORT_CI PO_CI) (SAME-CITY PO_CH AIRPORT_CH)
  (SAME-CITY AIRPORT_CH PO_CH) (SAME-CITY PO_CG AIRPORT_CG) (SAME-CITY AIRPORT_CG PO_CG) (SAME-CITY PO_CF AIRPORT_CF) (SAME-CITY AIRPORT_CF PO_CF)
  (SAME-CITY PO_CE AIRPORT_CE) (SAME-CITY AIRPORT_CE PO_CE) (SAME-CITY PO_CD AIRPORT_CD) (SAME-CITY AIRPORT_CD PO_CD) (SAME-CITY PO_CC AIRPORT_CC)
  (SAME-CITY AIRPORT_CC PO_CC) (SAME-CITY PO_CB AIRPORT_CB) (SAME-CITY AIRPORT_CB PO_CB) (SAME-CITY PO_CA AIRPORT_CA) (SAME-CITY AIRPORT_CA PO_CA)
  (LOC-AT PO_CJ CJ) (LOC-AT AIRPORT_CJ CJ) (LOC-AT PO_CI CI) (LOC-AT AIRPORT_CI CI) (LOC-AT PO_CH CH) (LOC-AT AIRPORT_CH CH) (LOC-AT PO_CG CG)
  (LOC-AT AIRPORT_CG CG) (LOC-AT PO_CF CF) (LOC-AT AIRPORT_CF CF) (LOC-AT PO_CE CE) (LOC-AT AIRPORT_CE CE) (LOC-AT PO_CD CD) (LOC-AT AIRPORT_CD CD)
  (LOC-AT PO_CC CC) (LOC-AT AIRPORT_CC CC) (LOC-AT PO_CB CB) (LOC-AT AIRPORT_CB CB) (LOC-AT PO_CA CA) (LOC-AT AIRPORT_CA CA) (INSIDE-TRUCK OBJC T_CA)
  (INSIDE-TRUCK OBJE T_CJ) (INSIDE-AIRPLANE OBJF PLANEB) (INSIDE-AIRPLANE OBJG PLANEB) (AT-OBJ OBJD PO_CG) (AT-OBJ OBJA PO_CB)
  (AT-OBJ OBJB AIRPORT_CA) (PART-OF T_CJ CJ) (PART-OF T_CI CI) (PART-OF T_CH CH) (PART-OF T_CG CG) (PART-OF T_CF CF) (PART-OF T_CE CE)
  (PART-OF T_CD CD) (PART-OF T_CC CC) (PART-OF T_CB CB) (PART-OF T_CA CA) (AT-AIRPLANE PLANEB AIRPORT_CG) (AT-AIRPLANE PLANED AIRPORT_CJ)
  (AT-AIRPLANE PLANEA AIRPORT_CB) (AT-AIRPLANE PLANEE AIRPORT_CE) (AT-AIRPLANE PLANEC AIRPORT_CH) (AT-TRUCK T_CJ AIRPORT_CJ)
  (AT-TRUCK T_CI AIRPORT_CI) (AT-TRUCK T_CH AIRPORT_CH) (AT-TRUCK T_CG PO_CG) (AT-TRUCK T_CF AIRPORT_CF) (AT-TRUCK T_CE PO_CE)
  (AT-TRUCK T_CD AIRPORT_CD) (AT-TRUCK T_CC AIRPORT_CC) (AT-TRUCK T_CB AIRPORT_CB) (AT-TRUCK T_CA AIRPORT_CA)))

  |#

;;; 
;;; The *predicates* variable hold a list of all of the state
;;; predicates in the plan. For the sample plan above, the value of
;;; *predicates* is the following.
;;; 
;;; (AT-TRUCK AT-AIRPLANE PART-OF AT-OBJ INSIDE-AIRPLANE INSIDE-TRUCK
;;;  LOC-AT SAME-CITY)
;;; 
;;; Note that they are in reverse order.
;;; 
;;; PRODIGY does not use the symbol-value of predicate symbols, so we
;;; will maintain a count of predicate occurences in the
;;; state. Because the first (and all) state(s) have 20 instances of
;;; the predicate SAME-CITY, the value of the symbol will be equal to
;;; the count 20.
;;; 
;;; The value of this variable is set by function
;;; init-domain-specific-vars depending upon the value of the
;;; current-domain parameter.
;;; 
(defvar *predicates* nil
  ;;'(HOLDING ARM-EMPTY ON ON-TABLE CLEAR)
  ;;'(CARRIABLE HOLDING IS-KEY DR-TO-RM INROOM UNLOCKED PUSHABLE 
  ;;  CONNECTS LOCKED DR-OPEN NEXT-TO DR-CLOSED ARM-EMPTY)
  ;;'(AT-TRUCK AT-AIRPLANE PART-OF AT-OBJ INSIDE-AIRPLANE 
  ;;  INSIDE-TRUCK LOC-AT SAME-CITY)
    )

;;; 
;;; The global variable *vector-results* holds the main results as
;;; computed by function solve-problems. Functions remove-nulls,
;;; create-skip-list, successes, failures, and examine-plans takes the
;;; results as parameter. Initialize sets the variable (back) to nil.
;;; 
(defvar *vector-results* nil
  "A list of vector representations for all solved plans.")

;;; The problems that have no solution.
(defvar *skip-list* nil
  "The problems that have no solution."
  )


;;; 
;;; Call function initialize before starting first run of each
;;; session. Pass to the call a constant from 'logistics,
;;; 'blocksworld, or 'extended-STRIPS.
;;; 
(defun initialize (&optional
		   (current-domain
		    'logistics))
  "Set vector results to nil, perform domain specific inits, and reset predicate list."
  (setf *vector-results* nil)
  (setf *target-width*
    (determine-target-width))
  (setf *increment-width* 
    (determine-increment-width))
  ;;Load PRODIGY domain
  (domain current-domain)
  (init-domain-specific-vars
   current-domain)
  (do-reset)				;after assignment of *predicates*
  )


;;; 
;;; Function init-domain-specific-vars assigns values to *predicates*
;;; and to *data-directory* depending upon the current-domain value.
;;; 
(defun init-domain-specific-vars (&optional
				  (current-domain
				   'logistics))
  (setf *predicates* 
    (enumerate-predicates))
  (case current-domain
    ('logistics
     (setf *predicates*
       '(AT-TRUCK AT-AIRPLANE PART-OF AT-OBJ INSIDE-AIRPLANE 
	 INSIDE-TRUCK LOC-AT SAME-CITY))
     (setf *data-directory*
       (format 
	nil 
	"~aa-distance/Logistics-data/Data6/"	
	*wrapper-home*))
     )
    ('blocksworld
     ;;(setf *predicates*
     ;;  '(HOLDING ARM-EMPTY ON ON-TABLE CLEAR))
     (setf *data-directory*
       (format 
	nil 
	"~aa-distance/Blocksworld-data/Data/"	
	*wrapper-home*))
     )
    ('extended-STRIPS
     ;;(setf *predicates*
     ;;  '(CARRIABLE HOLDING IS-KEY DR-TO-RM INROOM UNLOCKED PUSHABLE 
	;; CONNECTS LOCKED DR-OPEN NEXT-TO DR-CLOSED ARM-EMPTY))
     (setf *data-directory*
       (format 
	nil 
	"~aa-distance/Extended-STRIPS-data/Data/"	
	*wrapper-home*)))
    )
  )


;;; 
;;; Function remove-nulls takes the *vector-results* and removes all
;;; nil plans. A number of the plans may be NIL because the problems
;;; were not solvable (or not solvable within the time bound allowed;
;;; default 300 seconds). The function call also removes 'TRIVIAL
;;; markers that were inserted to indicate problems whose initial
;;; state included the goal state..
;;; 
(defun remove-nulls (&optional 
		     (plan-list
		      *vector-results*))
  (cond ((null plan-list)
	 nil)
	((or (null (first plan-list))
	     (eql 'TRIVIAL 
		  (first plan-list)))
	 (remove-nulls (rest plan-list)))
	(t
	 (cons (first plan-list)
	       (remove-nulls (rest plan-list))))))


;;; 
;;; Function examine-plans is used to print out the length of all
;;; vectors in all plans. This is useful to find vectors that have the
;;; extra left most element for the mystery predicate "done." NOTE
;;; that this is no longer very useful since I have fixed the problem
;;; with the done predicate.
;;; 
(defun examine-plans (&optional 
		      (plan-list
		       *vector-results*))
  (cond ((null plan-list)
	 nil)
	((null (first plan-list))
	 (examine-plans (rest plan-list)))
	(t
	 (print-lengths (first plan-list))
	 (examine-plans (rest plan-list)))
	)
  )


(defun print-lengths (plan)
  "print the length of all vectors in the input plan."
  (cond ((null plan)
	 nil)
	(t
	 (print (length (first plan)))
	 (print-lengths (rest plan))))
  )


;;; 
;;; Function convert2numbers takes a list of predicate counters in the
;;; state as input and returns a vector representation. The first
;;; state in the example above maps to the following.  (10 5 10 3 2 2
;;; 20 20)
;;; 
(defun convert2numbers (predicate-list)
  (cond ((null predicate-list)
	 nil)
	(t
	 (cons (symbol-value 
		(first predicate-list))
	       (convert2numbers 
		(rest predicate-list)))))
  )

;;; 
;;; Function do-reset re-initializes all predicate counts to zero.
;;; 
(defun do-reset (&optional
		 (predicate-list
		  *predicates*))
  (cond ((null predicate-list)
	 nil)
	(t 
	 (set (first predicate-list) 
	      0)
	 (do-reset 
	  (rest predicate-list))))
  )


;;; 
;;; Function convert2vector takes as input an intermediate state
;;; representation and converts it into vector form. The state is a
;;; list of predicate (i.e., literal) forms such as the predicate
;;; (SAME-CITY PO_CJ AIRPORT_CJ). The output vector is a list of
;;; integers that count the number of predicates of each type in the
;;; state.
;;; 
(defun convert2vector (state &aux return-val)
  (cond ((null state)
	 (setf return-val
	   (convert2numbers *predicates*))
	 (do-reset *predicates*)
	 return-val)
	(t
	 (let ((first-literal (first state)))
	   (when (not (boundp (first first-literal)))
	     (break)
	     (set (first first-literal) 0)
	     (setf *predicates*
	       (cons (first first-literal) *predicates*)))
	   (set (first first-literal) (+ 1 (symbol-value (first first-literal))))
	   (convert2vector (rest state)))))	 
  )


;;; 
;;; Call (plan2vectors (gen-file)) to get results. 
;;; the sample plan at the top of this file maps to the folloing sequence.
;;; ((10 5 10 3 2 2 20 20) (10 5 10 3 2 2 20 20) (10 5 10 2 2 3 20 20) 
;;;  (10 5 10 2 2 3 20 20) (10 5 10 3 2 2 20 20) (10 5 10 2 3 2 20 20)
;;;  (10 5 10 2 3 2 20 20) (10 5 10 3 2 2 20 20) (10 5 10 3 2 2 20 20) 
;;;  (10 5 10 2 2 3 20 20) (10 5 10 2 2 3 20 20) (10 5 10 3 2 2 20 20))
;;; 
(defun plan2vectors (plan)
  (cond ((null plan)
	 nil)
	(t
	 ;;; Because the plan is a sequence of (<action> <state>) pairs,
	 ;;; we convert the state (i.e., the second item)
	 (cons (convert2vector
		(second plan))
	       (plan2vectors
		(rest (rest plan))))))
  )


;;; The following shuffles a sequence including a list. 
;;; Got this code off the internet.
(defun seqrnd (seq)
  "Randomize the elements of a sequence. Destructive on SEQ."
  (sort seq #'> :key (lambda (x) (random 1.0))))


;;; 
;;; This is the code to execute the planning on the generated problems and to 
;;; save the vector translated results on the variable *vector-results*. Set 
;;; *skip-list* to nil to perform task on original problem set that includes 
;;; insolvable problems.
;;; 
;;; If write-file is non-nil (nil by default), then the *vector-results* are 
;;; written to disk in the file named file-name. Any data is appended to the 
;;; end of existing files of the same name.
;;; 
(defun solve-problems (&optional
		       (num-of-probs 100)
		       write-file
		       (time-bnd 300)
		       (file-name 
			(format 
			 nil 
			 "~adata.txt"
			 *data-directory*))
		       )
  (dotimes (i num-of-probs) 
    (when (not (member (intern (make-symbol (format nil "P~s" (1+ i)))) 
		       *skip-list*))
      (problem (intern (make-symbol (format nil "P~s" (1+ i)))))
      (run :time-bound time-bnd
	   :output-level 0)
      (sleep 2)
      (let ((plan-intermediate-state-rep (gen-file))) 
	;; For problems whose initial state includes the goal, we get
	;; a plan with the *FINISH* OP. These include DONE in the
	;; ending state and thus add an extra predicate to *predicates*.
	;; Here we test for this condition and insert 'TRIVIAL instead
	;; of a "null" plan (i.e., finish op only).
	(setf *vector-results*
	  (cons (if (eq 'P4::*FINISH* 
			(first 
			 (third 
			  plan-intermediate-state-rep)))
		    'TRIVIAL
		  (plan2vectors 
		   plan-intermediate-state-rep))
		*vector-results*))
	)))
  (if write-file
      (with-open-file
	  (f file-name
	   :direction :output
	   :if-exists :append
	   :if-does-not-exist :create)
	(format f ";;; Successes = ~F, Failures = ~F, and trivial successes = ~F out of ~F problems.~%"
		(successes)
		(failures)
		(trivials)
		(length *vector-results*))
	(format f "~S~%" *vector-results*)))
  )


;;; 
;;; Function read-data opens and read a file to obtain the value of
;;; *vector-results* (or other data) written some time previously by
;;; function solve-problems (or another function).
;;; 
(defun read-data (&optional
		  (ifile-name
		   (format 
		    nil 
		    "~adata.txt"
		    *data-directory*)))
  (with-open-file
   (ifile 
    ifile-name
    :direction :input)
   (read ifile))
  )


;;; 
;;; Function create-skip-list constructs a list of problem names such
;;; as the symbol P1. The problems that correspond to these names have
;;; no solutions (or were not solvable within the time bound
;;; allowed). The global *vector-results* indicates these
;;; non-solutions with the symbol NIL.  Because *vector-results* is in
;;; reverse order, the function first reverses the input plan-list. It
;;; then seeks NIL entries to indicate the culprits.  The global
;;; variable *skip-list* is set to the result. Because function
;;; solve-problems will not attempt to run PRODIGY on any problems
;;; corresponding to those in *skip-list*, calling this after a run on
;;; a set of problems will allow a quick subsequent run using a broken
;;; domain (one with a missing operator).
;;; 
;;; Call as follows. (create-skip-list *vector-results*)
;;;
(defun create-skip-list (&optional 
			 (plan-list
			  *vector-results*))
  "Finding the problems that have no solution."
  (let ((reversed-plan-list (reverse
			     plan-list)))
    (dotimes (i (length plan-list)) 
      (if (or (eql 'TRIVIAL 
		   (first reversed-plan-list))
	      (null (first reversed-plan-list)))
	  (setf *skip-list* 
	    (cons (intern 
		   (make-symbol 
		    (format nil "P~s" (1+ i))))
		  *skip-list*)))
      (setf reversed-plan-list 
	(rest reversed-plan-list))))
  )


;;;
;;; This function does not count problems whose goal state was already
;;; in the initial state. It only counts non-trivial plans. 
;;; 
(defun successes (&optional 
		  (plan-list
		   *vector-results*))
  "Return the number of problems solved successfully"
  (apply 
   #'+
   (mapcar #'(lambda (x)
	       (if (or (null x) 
		       (eql 'TRIVIAL x))
		   0
		 1))
	   plan-list))
  )


;;; 
;;; This function counts problems whose goal state was already in the
;;; initial state.
;;; 
(defun trivials (&optional 
		 (plan-list
		  *vector-results*))
  "Return the number of problems solved trivially"
  (apply 
   #'+
   (mapcar #'(lambda (x)
	       (if (eql 'TRIVIAL x)
		   1
		 0))
	   plan-list))
  )


(defun failures (&optional 
		 (plan-list
		  *vector-results*))
  "Return the number of problems not solved."
  (-
   (- (length plan-list)
      (successes plan-list))
   (trivials plan-list))
  )


;;; 
;;; 
;;; THIS FUNCTION IS NO LONGER RELEVANT. I FIXED THE PROBLEM THAT
;;; THIS SOLVED.
;;; 
;;; Function fix-it takes a plan list having some vectors that are too
;;; long due to the "problem of the DONE predicate" and returns a
;;; fixed plan with the long vectors trimmed of the leading predicate
;;; value. The length-of-long-vector needs to be set to the length of
;;; erroneous vectors that require the fix.
;;; 
;;; A plan with vectors of 4 instead of 3: ((0 0 8 8) (0 0 7 7) (0 1 7 7)) 
;;; So call (fix-it '(((0 0 8 8) (0 0 7 7) (0 1 7 7))) 4)
;;; 
(defun fix-it (plan-list 
	       length-of-long-vector)
  (cond ((null plan-list)
	 nil)
	(t
	 (cons (mapcar #'(lambda (x)
			   (if (equal 
				length-of-long-vector
				(length x))
			       (rest x)
			     x))
		       (first plan-list))
	       (fix-it (rest plan-list)
		       length-of-long-vector))))
  )


(defun plan-lengths (&optional 
		     (plan-list
		      *vector-results*))
  "Return a list of the lengths of all plans in the input plan list."
  (mapcar #'length plan-list)
  )


;;; 
;;; Function enumerate-predicates returns a list of all predicate
;;; symbols used in a Prodigy/Agent domain. The function uses calls to
;;; Prodigy4.0 code (indicated by the symbol package p4::).
;;; 
;;; NOTE the following. Rest removes p4:done. But is it
;;; probably unnecessary.
;;; 
(defun enumerate-predicates ()
  ;;(rest 
  (remove-duplicates 
   (apply #'append
	  (mapcar #'(lambda (op)
		      (append 
		       (p4::all-precond-preds op)
		       (p4::all-effects-preds op)))
		  (p4::problem-space-operators 
		   *current-problem-space*))))
   ;;)
  )


;;; 
;;; Function init-anomalous-run prepares the data structures and
;;; domain to run with an anomalous operator set. The function assumes
;;; that the non-anomalous domain has just been run on the current set
;;; of problems.
;;; 
(defun init-anomalous-run (&optional
			   (current-domain
			    'logistics))
  (create-skip-list *vector-results*)
  (change-file-names current-domain)
  (domain current-domain)
  (setf *vector-results* nil)
  ;; Then call (solve-problems 10 t 300 
	;;	(format  nil 
	;;		 "~adata-anomalous.txt"
	;;		 *data-directory*))
  )


;;; 
;;; Defun change-file-names renames the normal domain file to a
;;; temporary name and then renames domain.anomalous to domain.lisp
;;; (i.e., to the standard file name for a PRODIGY domain file).
;;; 
(defun change-file-names (&optional
			  (current-domain
			   'logistics))
  (rename-file (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.lisp")
	       (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.tmp"))
  (rename-file (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.anomalous")
	       (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.lisp"))
  )


;;; 
;;; Defun restore-file-names renames the domain file (which is assumed
;;; to be an anomalous domain) to domain.anomalous, and then renames
;;; domain.tmp back to domain.lisp. This should be called after
;;; solving problems with the anomalous domain to restore integrity to
;;; the file system.
;;; 
(defun restore-file-names (&optional
			   (current-domain
			    'logistics))
  (rename-file (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.lisp")
	       (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.anomalous"))
  (rename-file (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.tmp")
	       (format nil "~a~a~a"  
		       *world-path* 
		       (string-downcase 
			(symbol-name current-domain))
		       "/domain.lisp"))
  )
