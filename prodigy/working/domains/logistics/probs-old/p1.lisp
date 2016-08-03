#|

(defparameter
    *prob-list*
    '(p1 
      p2 
      p3 
      p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15))
(defparameter
    *prob-list*
  '(p1 
    p2 
    p3 
    p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15
    p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30))
(defparameter
    *prob-list*
    '(p7 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 )
|#
  
(setf (current-problem)
  (create-problem
    (name p1)
    (objects 
        (cityA cityB cityC cityD cityE cityF cityG cityH cityI cityJ CITY)
        (objectA objectB OBJECT)
        (truck_cityA truck_cityB truck_cityC truck_cityD truck_cityE truck_cityF truck_cityG truck_cityH truck_cityI truck_cityJ TRUCK)
        (airport_cityA airport_cityB airport_cityC airport_cityD airport_cityE airport_cityF airport_cityG airport_cityH airport_cityI airport_cityJ AIRPORT)
        (airplaneA AIRPLANE)
        (po_cityA po_cityB po_cityC po_cityD po_cityE po_cityF po_cityG po_cityH po_cityI po_cityJ POST-OFFICE)
)
    (state
      (and
          (loc-at airport_cityA cityA)
          (loc-at po_cityA cityA)
          (same-city airport_cityA po_cityA)
          (same-city po_cityA airport_cityA)
          (part-of truck_cityA cityA)
          (at-truck truck_cityA airport_cityA)
          (loc-at airport_cityB cityB)
          (loc-at po_cityB cityB)
          (same-city airport_cityB po_cityB)
          (same-city po_cityB airport_cityB)
          (part-of truck_cityB cityB)
          (at-truck truck_cityB airport_cityB)
          (loc-at airport_cityC cityC)
          (loc-at po_cityC cityC)
          (same-city airport_cityC po_cityC)
          (same-city po_cityC airport_cityC)
          (part-of truck_cityC cityC)
          (at-truck truck_cityC po_cityC)
          (loc-at airport_cityD cityD)
          (loc-at po_cityD cityD)
          (same-city airport_cityD po_cityD)
          (same-city po_cityD airport_cityD)
          (part-of truck_cityD cityD)
          (at-truck truck_cityD po_cityD)
          (loc-at airport_cityE cityE)
          (loc-at po_cityE cityE)
          (same-city airport_cityE po_cityE)
          (same-city po_cityE airport_cityE)
          (part-of truck_cityE cityE)
          (at-truck truck_cityE po_cityE)
          (loc-at airport_cityF cityF)
          (loc-at po_cityF cityF)
          (same-city airport_cityF po_cityF)
          (same-city po_cityF airport_cityF)
          (part-of truck_cityF cityF)
          (at-truck truck_cityF airport_cityF)
          (loc-at airport_cityG cityG)
          (loc-at po_cityG cityG)
          (same-city airport_cityG po_cityG)
          (same-city po_cityG airport_cityG)
          (part-of truck_cityG cityG)
          (at-truck truck_cityG po_cityG)
          (loc-at airport_cityH cityH)
          (loc-at po_cityH cityH)
          (same-city airport_cityH po_cityH)
          (same-city po_cityH airport_cityH)
          (part-of truck_cityH cityH)
          (at-truck truck_cityH po_cityH)
          (loc-at airport_cityI cityI)
          (loc-at po_cityI cityI)
          (same-city airport_cityI po_cityI)
          (same-city po_cityI airport_cityI)
          (part-of truck_cityI cityI)
          (at-truck truck_cityI po_cityI)
          (loc-at airport_cityJ cityJ)
          (loc-at po_cityJ cityJ)
          (same-city airport_cityJ po_cityJ)
          (same-city po_cityJ airport_cityJ)
          (part-of truck_cityJ cityJ)
          (at-truck truck_cityJ airport_cityJ)
          (at-airplane airplaneA airport_cityB)
          (at-obj objectA airport_cityA)
          (at-obj objectB airport_cityG)
))
    (goal
      (and
          (at-obj objectB airport_cityF)
          (at-obj objectA po_cityH)
))))