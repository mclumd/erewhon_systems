(setf (current-problem)
  (create-problem
    (name p14)
    (objects 
        (cA cB cC cD cE cF cG cH cI cJ CITY)
        (objA OBJECT)
        (t_cA t_cB t_cC t_cD t_cE t_cF t_cG t_cH t_cI t_cJ TRUCK)
        (airport_cA airport_cB airport_cC airport_cD airport_cE airport_cF airport_cG airport_cH airport_cI airport_cJ AIRPORT)
        (planeA AIRPLANE)
        (po_cA po_cB po_cC po_cD po_cE po_cF po_cG po_cH po_cI po_cJ POST-OFFICE)
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
          (at-truck t_cB po_cB)
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
          (loc-at airport_cG cG)
          (loc-at po_cG cG)
          (same-city airport_cG po_cG)
          (same-city po_cG airport_cG)
          (part-of t_cG cG)
          (at-truck t_cG po_cG)
          (loc-at airport_cH cH)
          (loc-at po_cH cH)
          (same-city airport_cH po_cH)
          (same-city po_cH airport_cH)
          (part-of t_cH cH)
          (at-truck t_cH po_cH)
          (loc-at airport_cI cI)
          (loc-at po_cI cI)
          (same-city airport_cI po_cI)
          (same-city po_cI airport_cI)
          (part-of t_cI cI)
          (at-truck t_cI airport_cI)
          (loc-at airport_cJ cJ)
          (loc-at po_cJ cJ)
          (same-city airport_cJ po_cJ)
          (same-city po_cJ airport_cJ)
          (part-of t_cJ cJ)
          (at-truck t_cJ po_cJ)
          (at-airplane planeA airport_cC)
          (inside-truck objA t_cF)
))
    (goal
      (and
          (at-obj objA airport_cI)
))))