(setf (current-problem)
  (create-problem
    (name p15)
    (objects 
        (cityA cityB cityC cityD cityE cityF cityG cityH cityI cityJ CITY)
        (objectA objectB objectC objectD objectE objectF objectG objectH objectI OBJECT)
        (truck_cityA truck_cityB truck_cityC truck_cityD truck_cityE truck_cityF truck_cityG truck_cityH truck_cityI truck_cityJ TRUCK)
        (airport_cityA airport_cityB airport_cityC airport_cityD airport_cityE airport_cityF airport_cityG airport_cityH airport_cityI airport_cityJ AIRPORT)
        (airplaneA airplaneB AIRPLANE)
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
          (at-truck truck_cityB po_cityB)
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
          (at-truck truck_cityE airport_cityE)
          (loc-at airport_cityF cityF)
          (loc-at po_cityF cityF)
          (same-city airport_cityF po_cityF)
          (same-city po_cityF airport_cityF)
          (part-of truck_cityF cityF)
          (at-truck truck_cityF po_cityF)
          (loc-at airport_cityG cityG)
          (loc-at po_cityG cityG)
          (same-city airport_cityG po_cityG)
          (same-city po_cityG airport_cityG)
          (part-of truck_cityG cityG)
          (at-truck truck_cityG airport_cityG)
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
          (at-truck truck_cityJ po_cityJ)
          (at-airplane airplaneB airport_cityH)
          (at-airplane airplaneA airport_cityG)
          (at-obj objectD po_cityI)
          (at-obj objectC airport_cityA)
          (inside-truck objectB truck_cityH)
          (inside-truck objectE truck_cityG)
          (inside-airplane objectG airplaneB)
          (inside-truck objectA truck_cityG)
          (inside-airplane objectI airplaneB)
          (inside-truck objectF truck_cityI)
          (at-obj objectH po_cityC)
))
    (goal
      (and
          (at-obj objectC airport_cityA)
))))