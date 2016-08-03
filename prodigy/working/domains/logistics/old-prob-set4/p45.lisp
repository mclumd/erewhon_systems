(setf (current-problem)
  (create-problem
    (name p45)
    (objects 
        (cA cB cC cD cE cF CITY)
        (objA objB objC OBJECT)
        (t_cA t_cB t_cC t_cD t_cE t_cF TRUCK)
        (airport_cA airport_cB airport_cC airport_cD airport_cE airport_cF AIRPORT)
        (planeA planeB planeC planeD planeE planeF planeG planeH planeI AIRPLANE)
        (po_cA po_cB po_cC po_cD po_cE po_cF POST-OFFICE)
)
    (state
      (and
          (loc-at airport_cA cA)
          (loc-at po_cA cA)
          (same-city airport_cA po_cA)
          (same-city po_cA airport_cA)
          (part-of t_cA cA)
          (at-truck t_cA po_cA)
          (loc-at airport_cB cB)
          (loc-at po_cB cB)
          (same-city airport_cB po_cB)
          (same-city po_cB airport_cB)
          (part-of t_cB cB)
          (at-truck t_cB airport_cB)
          (loc-at airport_cC cC)
          (loc-at po_cC cC)
          (same-city airport_cC po_cC)
          (same-city po_cC airport_cC)
          (part-of t_cC cC)
          (at-truck t_cC airport_cC)
          (loc-at airport_cD cD)
          (loc-at po_cD cD)
          (same-city airport_cD po_cD)
          (same-city po_cD airport_cD)
          (part-of t_cD cD)
          (at-truck t_cD airport_cD)
          (loc-at airport_cE cE)
          (loc-at po_cE cE)
          (same-city airport_cE po_cE)
          (same-city po_cE airport_cE)
          (part-of t_cE cE)
          (at-truck t_cE airport_cE)
          (loc-at airport_cF cF)
          (loc-at po_cF cF)
          (same-city airport_cF po_cF)
          (same-city po_cF airport_cF)
          (part-of t_cF cF)
          (at-truck t_cF po_cF)
          (at-airplane planeI airport_cC)
          (at-airplane planeH airport_cA)
          (at-airplane planeA airport_cC)
          (at-airplane planeC airport_cB)
          (at-airplane planeG airport_cC)
          (at-airplane planeB airport_cE)
          (at-airplane planeD airport_cB)
          (at-airplane planeE airport_cE)
          (at-airplane planeF airport_cE)
          (at-obj objA po_cD)
          (at-obj objC po_cB)
          (inside-truck objB t_cE)
))
    (goal
      (and
          (at-obj objC po_cC)
))))