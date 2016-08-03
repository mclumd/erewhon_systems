(define (problem LOG-RAN-15-3)
(:domain logistics)
(:objects PLANE1 PLANE2 PLANE3 TRUCK1-1 LOC1-1 CITY1 TRUCK2-1 LOC2-1 LOC2-2 LOC2-3 CITY2 TRUCK3-1 CITY3 TRUCK4-1 LOC4-1 LOC4-2 CITY4 TRUCK5-1 LOC5-1 LOC5-2 CITY5 TRUCK6-1 CITY6 TRUCK7-1 LOC7-3 CITY7 TRUCK8-1 LOC8-1 LOC8-2 CITY8 PACKAGE1 LOC7-1 PACKAGE2 LOC6-2 PACKAGE3 LOC3-2 PACKAGE4 LOC5-3 PACKAGE5 LOC4-3 PACKAGE6 LOC6-3 PACKAGE7 PACKAGE8 LOC3-3 PACKAGE9 LOC8-3 PACKAGE10 PACKAGE11 LOC3-1 PACKAGE12 LOC6-1 PACKAGE13 LOC1-2 PACKAGE14 LOC7-2 PACKAGE15 LOC1-3 )
(:init (AIRPLANE PLANE1)
(AIRPLANE-AT PLANE1 LOC4-1)
(AIRPLANE PLANE2)
(AIRPLANE-AT PLANE2 LOC3-1)
(AIRPLANE PLANE3)
(AIRPLANE-AT PLANE3 LOC3-1)
(CITY CITY1)
(AIRPORT LOC1-1)
(TRUCK TRUCK1-1 CITY1)
(TRUCK-AT TRUCK1-1 LOC1-1)
(LOCATION LOC1-1)
(IN-CITY LOC1-1 CITY1)
(LOCATION LOC1-2)
(IN-CITY LOC1-2 CITY1)
(LOCATION LOC1-3)
(IN-CITY LOC1-3 CITY1)
(CITY CITY2)
(AIRPORT LOC2-1)
(TRUCK TRUCK2-1 CITY2)
(TRUCK-AT TRUCK2-1 LOC2-1)
(LOCATION LOC2-1)
(IN-CITY LOC2-1 CITY2)
(LOCATION LOC2-2)
(IN-CITY LOC2-2 CITY2)
(LOCATION LOC2-3)
(IN-CITY LOC2-3 CITY2)
(CITY CITY3)
(AIRPORT LOC3-1)
(TRUCK TRUCK3-1 CITY3)
(TRUCK-AT TRUCK3-1 LOC3-1)
(LOCATION LOC3-1)
(IN-CITY LOC3-1 CITY3)
(LOCATION LOC3-2)
(IN-CITY LOC3-2 CITY3)
(LOCATION LOC3-3)
(IN-CITY LOC3-3 CITY3)
(CITY CITY4)
(AIRPORT LOC4-1)
(TRUCK TRUCK4-1 CITY4)
(TRUCK-AT TRUCK4-1 LOC4-1)
(LOCATION LOC4-1)
(IN-CITY LOC4-1 CITY4)
(LOCATION LOC4-2)
(IN-CITY LOC4-2 CITY4)
(LOCATION LOC4-3)
(IN-CITY LOC4-3 CITY4)
(CITY CITY5)
(AIRPORT LOC5-1)
(TRUCK TRUCK5-1 CITY5)
(TRUCK-AT TRUCK5-1 LOC5-1)
(LOCATION LOC5-1)
(IN-CITY LOC5-1 CITY5)
(LOCATION LOC5-2)
(IN-CITY LOC5-2 CITY5)
(LOCATION LOC5-3)
(IN-CITY LOC5-3 CITY5)
(CITY CITY6)
(AIRPORT LOC6-1)
(TRUCK TRUCK6-1 CITY6)
(TRUCK-AT TRUCK6-1 LOC6-1)
(LOCATION LOC6-1)
(IN-CITY LOC6-1 CITY6)
(LOCATION LOC6-2)
(IN-CITY LOC6-2 CITY6)
(LOCATION LOC6-3)
(IN-CITY LOC6-3 CITY6)
(CITY CITY7)
(AIRPORT LOC7-1)
(TRUCK TRUCK7-1 CITY7)
(TRUCK-AT TRUCK7-1 LOC7-1)
(LOCATION LOC7-1)
(IN-CITY LOC7-1 CITY7)
(LOCATION LOC7-2)
(IN-CITY LOC7-2 CITY7)
(LOCATION LOC7-3)
(IN-CITY LOC7-3 CITY7)
(CITY CITY8)
(AIRPORT LOC8-1)
(TRUCK TRUCK8-1 CITY8)
(TRUCK-AT TRUCK8-1 LOC8-1)
(LOCATION LOC8-1)
(IN-CITY LOC8-1 CITY8)
(LOCATION LOC8-2)
(IN-CITY LOC8-2 CITY8)
(LOCATION LOC8-3)
(IN-CITY LOC8-3 CITY8)
(OBJ-AT PACKAGE1 LOC7-1)
(OBJ-AT PACKAGE2 LOC6-2)
(OBJ-AT PACKAGE3 LOC3-2)
(OBJ-AT PACKAGE4 LOC5-3)
(OBJ-AT PACKAGE5 LOC4-3)
(OBJ-AT PACKAGE6 LOC6-3)
(OBJ-AT PACKAGE7 LOC3-3)
(OBJ-AT PACKAGE8 LOC3-3)
(OBJ-AT PACKAGE9 LOC8-3)
(OBJ-AT PACKAGE10 LOC1-2)
(OBJ-AT PACKAGE11 LOC3-1)
(OBJ-AT PACKAGE12 LOC6-1)
(OBJ-AT PACKAGE13 LOC1-2)
(OBJ-AT PACKAGE14 LOC7-2)
(OBJ-AT PACKAGE15 LOC1-3)
)
(:goal (AND (OBJ-AT PACKAGE1 LOC1-1) (OBJ-AT PACKAGE2 LOC8-2)
            (OBJ-AT PACKAGE3 LOC8-3) (OBJ-AT PACKAGE4 LOC2-1)
            (OBJ-AT PACKAGE5 LOC6-2) (OBJ-AT PACKAGE6 LOC8-3)
            (OBJ-AT PACKAGE7 LOC3-1) (OBJ-AT PACKAGE8 LOC6-1)
            (OBJ-AT PACKAGE9 LOC1-2) (OBJ-AT PACKAGE10 LOC5-2)
            (OBJ-AT PACKAGE11 LOC2-1) (OBJ-AT PACKAGE12 LOC3-3)
            (OBJ-AT PACKAGE13 LOC3-3) (OBJ-AT PACKAGE14 LOC2-1)
            (OBJ-AT PACKAGE15 LOC7-2)))
)