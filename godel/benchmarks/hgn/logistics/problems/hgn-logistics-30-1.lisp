(in-package :shop2) 
(DEFPROBLEM LOG-RAN-30-1 LOGISTICS
 ((AIRPLANE PLANE1) (AIRPLANE-AT PLANE1 LOC12-1) (AIRPLANE PLANE2)
  (AIRPLANE-AT PLANE2 LOC12-1) (AIRPLANE PLANE3)
  (AIRPLANE-AT PLANE3 LOC10-1) (AIRPLANE PLANE4)
  (AIRPLANE-AT PLANE4 LOC3-1) (AIRPLANE PLANE5)
  (AIRPLANE-AT PLANE5 LOC12-1) (AIRPLANE PLANE6)
  (AIRPLANE-AT PLANE6 LOC11-1) (CITY CITY1) (AIRPORT LOC1-1)
  (TRUCK TRUCK1-1 CITY1) (TRUCK-AT TRUCK1-1 LOC1-1) (LOCATION LOC1-1)
  (IN-CITY LOC1-1 CITY1) (LOCATION LOC1-2) (IN-CITY LOC1-2 CITY1)
  (LOCATION LOC1-3) (IN-CITY LOC1-3 CITY1) (CITY CITY2)
  (AIRPORT LOC2-1) (TRUCK TRUCK2-1 CITY2) (TRUCK-AT TRUCK2-1 LOC2-1)
  (LOCATION LOC2-1) (IN-CITY LOC2-1 CITY2) (LOCATION LOC2-2)
  (IN-CITY LOC2-2 CITY2) (LOCATION LOC2-3) (IN-CITY LOC2-3 CITY2)
  (CITY CITY3) (AIRPORT LOC3-1) (TRUCK TRUCK3-1 CITY3)
  (TRUCK-AT TRUCK3-1 LOC3-1) (LOCATION LOC3-1) (IN-CITY LOC3-1 CITY3)
  (LOCATION LOC3-2) (IN-CITY LOC3-2 CITY3) (LOCATION LOC3-3)
  (IN-CITY LOC3-3 CITY3) (CITY CITY4) (AIRPORT LOC4-1)
  (TRUCK TRUCK4-1 CITY4) (TRUCK-AT TRUCK4-1 LOC4-1) (LOCATION LOC4-1)
  (IN-CITY LOC4-1 CITY4) (LOCATION LOC4-2) (IN-CITY LOC4-2 CITY4)
  (LOCATION LOC4-3) (IN-CITY LOC4-3 CITY4) (CITY CITY5)
  (AIRPORT LOC5-1) (TRUCK TRUCK5-1 CITY5) (TRUCK-AT TRUCK5-1 LOC5-1)
  (LOCATION LOC5-1) (IN-CITY LOC5-1 CITY5) (LOCATION LOC5-2)
  (IN-CITY LOC5-2 CITY5) (LOCATION LOC5-3) (IN-CITY LOC5-3 CITY5)
  (CITY CITY6) (AIRPORT LOC6-1) (TRUCK TRUCK6-1 CITY6)
  (TRUCK-AT TRUCK6-1 LOC6-1) (LOCATION LOC6-1) (IN-CITY LOC6-1 CITY6)
  (LOCATION LOC6-2) (IN-CITY LOC6-2 CITY6) (LOCATION LOC6-3)
  (IN-CITY LOC6-3 CITY6) (CITY CITY7) (AIRPORT LOC7-1)
  (TRUCK TRUCK7-1 CITY7) (TRUCK-AT TRUCK7-1 LOC7-1) (LOCATION LOC7-1)
  (IN-CITY LOC7-1 CITY7) (LOCATION LOC7-2) (IN-CITY LOC7-2 CITY7)
  (LOCATION LOC7-3) (IN-CITY LOC7-3 CITY7) (CITY CITY8)
  (AIRPORT LOC8-1) (TRUCK TRUCK8-1 CITY8) (TRUCK-AT TRUCK8-1 LOC8-1)
  (LOCATION LOC8-1) (IN-CITY LOC8-1 CITY8) (LOCATION LOC8-2)
  (IN-CITY LOC8-2 CITY8) (LOCATION LOC8-3) (IN-CITY LOC8-3 CITY8)
  (CITY CITY9) (AIRPORT LOC9-1) (TRUCK TRUCK9-1 CITY9)
  (TRUCK-AT TRUCK9-1 LOC9-1) (LOCATION LOC9-1) (IN-CITY LOC9-1 CITY9)
  (LOCATION LOC9-2) (IN-CITY LOC9-2 CITY9) (LOCATION LOC9-3)
  (IN-CITY LOC9-3 CITY9) (CITY CITY10) (AIRPORT LOC10-1)
  (TRUCK TRUCK10-1 CITY10) (TRUCK-AT TRUCK10-1 LOC10-1)
  (LOCATION LOC10-1) (IN-CITY LOC10-1 CITY10) (LOCATION LOC10-2)
  (IN-CITY LOC10-2 CITY10) (LOCATION LOC10-3) (IN-CITY LOC10-3 CITY10)
  (CITY CITY11) (AIRPORT LOC11-1) (TRUCK TRUCK11-1 CITY11)
  (TRUCK-AT TRUCK11-1 LOC11-1) (LOCATION LOC11-1)
  (IN-CITY LOC11-1 CITY11) (LOCATION LOC11-2) (IN-CITY LOC11-2 CITY11)
  (LOCATION LOC11-3) (IN-CITY LOC11-3 CITY11) (CITY CITY12)
  (AIRPORT LOC12-1) (TRUCK TRUCK12-1 CITY12)
  (TRUCK-AT TRUCK12-1 LOC12-1) (LOCATION LOC12-1)
  (IN-CITY LOC12-1 CITY12) (LOCATION LOC12-2) (IN-CITY LOC12-2 CITY12)
  (LOCATION LOC12-3) (IN-CITY LOC12-3 CITY12) (CITY CITY13)
  (AIRPORT LOC13-1) (TRUCK TRUCK13-1 CITY13)
  (TRUCK-AT TRUCK13-1 LOC13-1) (LOCATION LOC13-1)
  (IN-CITY LOC13-1 CITY13) (LOCATION LOC13-2) (IN-CITY LOC13-2 CITY13)
  (LOCATION LOC13-3) (IN-CITY LOC13-3 CITY13) (CITY CITY14)
  (AIRPORT LOC14-1) (TRUCK TRUCK14-1 CITY14)
  (TRUCK-AT TRUCK14-1 LOC14-1) (LOCATION LOC14-1)
  (IN-CITY LOC14-1 CITY14) (LOCATION LOC14-2) (IN-CITY LOC14-2 CITY14)
  (LOCATION LOC14-3) (IN-CITY LOC14-3 CITY14) (CITY CITY15)
  (AIRPORT LOC15-1) (TRUCK TRUCK15-1 CITY15)
  (TRUCK-AT TRUCK15-1 LOC15-1) (LOCATION LOC15-1)
  (IN-CITY LOC15-1 CITY15) (LOCATION LOC15-2) (IN-CITY LOC15-2 CITY15)
  (LOCATION LOC15-3) (IN-CITY LOC15-3 CITY15) (OBJ-AT PACKAGE1 LOC6-3)
  (OBJ-AT PACKAGE2 LOC8-2) (OBJ-AT PACKAGE3 LOC11-3)
  (OBJ-AT PACKAGE4 LOC10-1) (OBJ-AT PACKAGE5 LOC1-1)
  (OBJ-AT PACKAGE6 LOC9-1) (OBJ-AT PACKAGE7 LOC13-3)
  (OBJ-AT PACKAGE8 LOC4-1) (OBJ-AT PACKAGE9 LOC2-1)
  (OBJ-AT PACKAGE10 LOC2-3) (OBJ-AT PACKAGE11 LOC9-2)
  (OBJ-AT PACKAGE12 LOC13-2) (OBJ-AT PACKAGE13 LOC8-3)
  (OBJ-AT PACKAGE14 LOC11-1) (OBJ-AT PACKAGE15 LOC3-2)
  (OBJ-AT PACKAGE16 LOC11-1) (OBJ-AT PACKAGE17 LOC15-2)
  (OBJ-AT PACKAGE18 LOC6-2) (OBJ-AT PACKAGE19 LOC10-2)
  (OBJ-AT PACKAGE20 LOC5-3) (OBJ-AT PACKAGE21 LOC7-3)
  (OBJ-AT PACKAGE22 LOC10-2) (OBJ-AT PACKAGE23 LOC1-3)
  (OBJ-AT PACKAGE24 LOC7-2) (OBJ-AT PACKAGE25 LOC8-2)
  (OBJ-AT PACKAGE26 LOC10-1) (OBJ-AT PACKAGE27 LOC8-2)
  (OBJ-AT PACKAGE28 LOC14-3) (OBJ-AT PACKAGE29 LOC6-1)
  (OBJ-AT PACKAGE30 LOC4-3))
 ((OBJ-AT PACKAGE1 LOC3-1) (OBJ-AT PACKAGE2 LOC10-3)
  (OBJ-AT PACKAGE3 LOC5-2) (OBJ-AT PACKAGE4 LOC8-1)
  (OBJ-AT PACKAGE5 LOC6-1) (OBJ-AT PACKAGE6 LOC13-3)
  (OBJ-AT PACKAGE7 LOC1-3) (OBJ-AT PACKAGE8 LOC15-2)
  (OBJ-AT PACKAGE9 LOC11-1) (OBJ-AT PACKAGE10 LOC5-3)
  (OBJ-AT PACKAGE11 LOC13-1) (OBJ-AT PACKAGE12 LOC11-3)
  (OBJ-AT PACKAGE13 LOC14-2) (OBJ-AT PACKAGE14 LOC2-1)
  (OBJ-AT PACKAGE15 LOC13-2) (OBJ-AT PACKAGE16 LOC11-2)
  (OBJ-AT PACKAGE17 LOC6-1) (OBJ-AT PACKAGE18 LOC11-2)
  (OBJ-AT PACKAGE19 LOC15-2) (OBJ-AT PACKAGE20 LOC10-2)
  (OBJ-AT PACKAGE21 LOC1-1) (OBJ-AT PACKAGE22 LOC7-3)
  (OBJ-AT PACKAGE23 LOC13-2) (OBJ-AT PACKAGE24 LOC3-1)
  (OBJ-AT PACKAGE25 LOC9-1) (OBJ-AT PACKAGE26 LOC4-1)
  (OBJ-AT PACKAGE27 LOC7-3) (OBJ-AT PACKAGE28 LOC1-1)
  (OBJ-AT PACKAGE29 LOC12-2) (OBJ-AT PACKAGE30 LOC8-2)))