(in-package :shop2) 
(DEFPROBLEM LOG-RAN-50-4 LOGISTICS
 ((AIRPLANE PLANE1) (AIRPLANE-AT PLANE1 LOC6-1) (AIRPLANE PLANE2)
  (AIRPLANE-AT PLANE2 LOC17-1) (AIRPLANE PLANE3)
  (AIRPLANE-AT PLANE3 LOC14-1) (AIRPLANE PLANE4)
  (AIRPLANE-AT PLANE4 LOC2-1) (AIRPLANE PLANE5)
  (AIRPLANE-AT PLANE5 LOC18-1) (AIRPLANE PLANE6)
  (AIRPLANE-AT PLANE6 LOC24-1) (AIRPLANE PLANE7)
  (AIRPLANE-AT PLANE7 LOC4-1) (AIRPLANE PLANE8)
  (AIRPLANE-AT PLANE8 LOC4-1) (AIRPLANE PLANE9)
  (AIRPLANE-AT PLANE9 LOC18-1) (AIRPLANE PLANE10)
  (AIRPLANE-AT PLANE10 LOC18-1) (CITY CITY1) (AIRPORT LOC1-1)
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
  (LOCATION LOC15-3) (IN-CITY LOC15-3 CITY15) (CITY CITY16)
  (AIRPORT LOC16-1) (TRUCK TRUCK16-1 CITY16)
  (TRUCK-AT TRUCK16-1 LOC16-1) (LOCATION LOC16-1)
  (IN-CITY LOC16-1 CITY16) (LOCATION LOC16-2) (IN-CITY LOC16-2 CITY16)
  (LOCATION LOC16-3) (IN-CITY LOC16-3 CITY16) (CITY CITY17)
  (AIRPORT LOC17-1) (TRUCK TRUCK17-1 CITY17)
  (TRUCK-AT TRUCK17-1 LOC17-1) (LOCATION LOC17-1)
  (IN-CITY LOC17-1 CITY17) (LOCATION LOC17-2) (IN-CITY LOC17-2 CITY17)
  (LOCATION LOC17-3) (IN-CITY LOC17-3 CITY17) (CITY CITY18)
  (AIRPORT LOC18-1) (TRUCK TRUCK18-1 CITY18)
  (TRUCK-AT TRUCK18-1 LOC18-1) (LOCATION LOC18-1)
  (IN-CITY LOC18-1 CITY18) (LOCATION LOC18-2) (IN-CITY LOC18-2 CITY18)
  (LOCATION LOC18-3) (IN-CITY LOC18-3 CITY18) (CITY CITY19)
  (AIRPORT LOC19-1) (TRUCK TRUCK19-1 CITY19)
  (TRUCK-AT TRUCK19-1 LOC19-1) (LOCATION LOC19-1)
  (IN-CITY LOC19-1 CITY19) (LOCATION LOC19-2) (IN-CITY LOC19-2 CITY19)
  (LOCATION LOC19-3) (IN-CITY LOC19-3 CITY19) (CITY CITY20)
  (AIRPORT LOC20-1) (TRUCK TRUCK20-1 CITY20)
  (TRUCK-AT TRUCK20-1 LOC20-1) (LOCATION LOC20-1)
  (IN-CITY LOC20-1 CITY20) (LOCATION LOC20-2) (IN-CITY LOC20-2 CITY20)
  (LOCATION LOC20-3) (IN-CITY LOC20-3 CITY20) (CITY CITY21)
  (AIRPORT LOC21-1) (TRUCK TRUCK21-1 CITY21)
  (TRUCK-AT TRUCK21-1 LOC21-1) (LOCATION LOC21-1)
  (IN-CITY LOC21-1 CITY21) (LOCATION LOC21-2) (IN-CITY LOC21-2 CITY21)
  (LOCATION LOC21-3) (IN-CITY LOC21-3 CITY21) (CITY CITY22)
  (AIRPORT LOC22-1) (TRUCK TRUCK22-1 CITY22)
  (TRUCK-AT TRUCK22-1 LOC22-1) (LOCATION LOC22-1)
  (IN-CITY LOC22-1 CITY22) (LOCATION LOC22-2) (IN-CITY LOC22-2 CITY22)
  (LOCATION LOC22-3) (IN-CITY LOC22-3 CITY22) (CITY CITY23)
  (AIRPORT LOC23-1) (TRUCK TRUCK23-1 CITY23)
  (TRUCK-AT TRUCK23-1 LOC23-1) (LOCATION LOC23-1)
  (IN-CITY LOC23-1 CITY23) (LOCATION LOC23-2) (IN-CITY LOC23-2 CITY23)
  (LOCATION LOC23-3) (IN-CITY LOC23-3 CITY23) (CITY CITY24)
  (AIRPORT LOC24-1) (TRUCK TRUCK24-1 CITY24)
  (TRUCK-AT TRUCK24-1 LOC24-1) (LOCATION LOC24-1)
  (IN-CITY LOC24-1 CITY24) (LOCATION LOC24-2) (IN-CITY LOC24-2 CITY24)
  (LOCATION LOC24-3) (IN-CITY LOC24-3 CITY24) (CITY CITY25)
  (AIRPORT LOC25-1) (TRUCK TRUCK25-1 CITY25)
  (TRUCK-AT TRUCK25-1 LOC25-1) (LOCATION LOC25-1)
  (IN-CITY LOC25-1 CITY25) (LOCATION LOC25-2) (IN-CITY LOC25-2 CITY25)
  (LOCATION LOC25-3) (IN-CITY LOC25-3 CITY25) (OBJ-AT PACKAGE1 LOC5-2)
  (OBJ-AT PACKAGE2 LOC2-1) (OBJ-AT PACKAGE3 LOC21-3)
  (OBJ-AT PACKAGE4 LOC4-2) (OBJ-AT PACKAGE5 LOC5-2)
  (OBJ-AT PACKAGE6 LOC24-2) (OBJ-AT PACKAGE7 LOC20-2)
  (OBJ-AT PACKAGE8 LOC12-2) (OBJ-AT PACKAGE9 LOC7-1)
  (OBJ-AT PACKAGE10 LOC22-3) (OBJ-AT PACKAGE11 LOC11-2)
  (OBJ-AT PACKAGE12 LOC1-2) (OBJ-AT PACKAGE13 LOC16-3)
  (OBJ-AT PACKAGE14 LOC12-1) (OBJ-AT PACKAGE15 LOC14-1)
  (OBJ-AT PACKAGE16 LOC23-3) (OBJ-AT PACKAGE17 LOC6-3)
  (OBJ-AT PACKAGE18 LOC14-3) (OBJ-AT PACKAGE19 LOC11-1)
  (OBJ-AT PACKAGE20 LOC25-1) (OBJ-AT PACKAGE21 LOC13-3)
  (OBJ-AT PACKAGE22 LOC7-1) (OBJ-AT PACKAGE23 LOC6-1)
  (OBJ-AT PACKAGE24 LOC4-1) (OBJ-AT PACKAGE25 LOC12-2)
  (OBJ-AT PACKAGE26 LOC3-2) (OBJ-AT PACKAGE27 LOC22-3)
  (OBJ-AT PACKAGE28 LOC11-1) (OBJ-AT PACKAGE29 LOC25-2)
  (OBJ-AT PACKAGE30 LOC3-2) (OBJ-AT PACKAGE31 LOC18-1)
  (OBJ-AT PACKAGE32 LOC5-3) (OBJ-AT PACKAGE33 LOC17-1)
  (OBJ-AT PACKAGE34 LOC17-2) (OBJ-AT PACKAGE35 LOC21-3)
  (OBJ-AT PACKAGE36 LOC1-3) (OBJ-AT PACKAGE37 LOC7-3)
  (OBJ-AT PACKAGE38 LOC20-3) (OBJ-AT PACKAGE39 LOC4-3)
  (OBJ-AT PACKAGE40 LOC21-3) (OBJ-AT PACKAGE41 LOC1-3)
  (OBJ-AT PACKAGE42 LOC1-1) (OBJ-AT PACKAGE43 LOC13-1)
  (OBJ-AT PACKAGE44 LOC21-2) (OBJ-AT PACKAGE45 LOC8-2)
  (OBJ-AT PACKAGE46 LOC1-2) (OBJ-AT PACKAGE47 LOC5-3)
  (OBJ-AT PACKAGE48 LOC24-2) (OBJ-AT PACKAGE49 LOC7-3)
  (OBJ-AT PACKAGE50 LOC4-3))
 ((OBJ-AT PACKAGE1 LOC3-1) (OBJ-AT PACKAGE2 LOC22-2)
  (OBJ-AT PACKAGE3 LOC20-1) (OBJ-AT PACKAGE4 LOC23-2)
  (OBJ-AT PACKAGE5 LOC4-1) (OBJ-AT PACKAGE6 LOC7-3)
  (OBJ-AT PACKAGE7 LOC16-2) (OBJ-AT PACKAGE8 LOC4-2)
  (OBJ-AT PACKAGE9 LOC2-2) (OBJ-AT PACKAGE10 LOC25-1)
  (OBJ-AT PACKAGE11 LOC5-2) (OBJ-AT PACKAGE12 LOC21-3)
  (OBJ-AT PACKAGE13 LOC12-3) (OBJ-AT PACKAGE14 LOC15-3)
  (OBJ-AT PACKAGE15 LOC4-2) (OBJ-AT PACKAGE16 LOC18-2)
  (OBJ-AT PACKAGE17 LOC24-3) (OBJ-AT PACKAGE18 LOC2-2)
  (OBJ-AT PACKAGE19 LOC10-3) (OBJ-AT PACKAGE20 LOC8-1)
  (OBJ-AT PACKAGE21 LOC15-3) (OBJ-AT PACKAGE22 LOC8-2)
  (OBJ-AT PACKAGE23 LOC11-1) (OBJ-AT PACKAGE24 LOC4-2)
  (OBJ-AT PACKAGE25 LOC25-3) (OBJ-AT PACKAGE26 LOC15-1)
  (OBJ-AT PACKAGE27 LOC21-2) (OBJ-AT PACKAGE28 LOC13-2)
  (OBJ-AT PACKAGE29 LOC22-1) (OBJ-AT PACKAGE30 LOC13-2)
  (OBJ-AT PACKAGE31 LOC1-1) (OBJ-AT PACKAGE32 LOC23-3)
  (OBJ-AT PACKAGE33 LOC12-1) (OBJ-AT PACKAGE34 LOC2-2)
  (OBJ-AT PACKAGE35 LOC8-3) (OBJ-AT PACKAGE36 LOC23-2)
  (OBJ-AT PACKAGE37 LOC1-2) (OBJ-AT PACKAGE38 LOC17-3)
  (OBJ-AT PACKAGE39 LOC24-1) (OBJ-AT PACKAGE40 LOC4-2)
  (OBJ-AT PACKAGE41 LOC10-3) (OBJ-AT PACKAGE42 LOC22-1)
  (OBJ-AT PACKAGE43 LOC6-1) (OBJ-AT PACKAGE44 LOC9-2)
  (OBJ-AT PACKAGE45 LOC8-3) (OBJ-AT PACKAGE46 LOC8-2)
  (OBJ-AT PACKAGE47 LOC16-2) (OBJ-AT PACKAGE48 LOC16-3)
  (OBJ-AT PACKAGE49 LOC18-1) (OBJ-AT PACKAGE50 LOC15-3)))