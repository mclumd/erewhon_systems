(setf (current-problem)
  (create-problem
    (name p55)
    (objects 
        (cA cB cC cD cE cF CITY)
        (objA objB objC objD objE objF objG OBJECT)
        (t_cA t_cB t_cC t_cD t_cE t_cF TRUCK)
        (airport_cA airport_cB airport_cC airport_cD airport_cE airport_cF AIRPORT)
        (planeA planeB planeC planeD planeE planeF AIRPLANE)
        (po_cA po_cB po_cC po_cD po_cE po_cF POST-OFFICE)
)
    (state
      (and
          (loc-at airport_cA cA)
          (loc-at po_cA cA)
          (same-city airport_cA po_cA)
          (same-city po_cA airport_cA)
          (part-of t_cA cA)
          (at-truck t_cA airport_cA)
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
          (at-truck t_cC po_cC)
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
          (at-truck t_cF airport_cF)
          (at-airplane planeE airport_cD)
          (at-airplane planeA airport_cA)
          (at-airplane planeC airport_cD)
          (at-airplane planeF airport_cB)
          (at-airplane planeB airport_cF)
          (at-airplane planeD airport_cF)
          (inside-truck objD t_cF)
          (inside-truck objF t_cA)
          (inside-airplane objC planeD)
          (at-obj objA airport_cC)
          (inside-airplane objG planeD)
          (inside-truck objE t_cB)
          (inside-airplane objB planeE)
))
    (goal
      (and
          (at-obj objG po_cF)
          (at-obj objF airport_cE)
          (at-obj objB airport_cC)
          (at-obj objD airport_cC)
          (at-obj objC po_cC)
))))