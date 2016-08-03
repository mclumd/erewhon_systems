(defparameter
    *test-performative*

    '(standby :content 
      (achieve 
       :time-bound 1000
       :content 
       (((at-obj package1 bos-po))
	((object-is package1 OBJECT)
	 (object-is package2 OBJECT)
	 (object-is package3 OBJECT)
	 (objects-are pgh-truck bos-truck1 bos-truck2 TRUCK)
	 (objects-are airplane1 airplane2 AIRPLANE)
	 (objects-are bos-po pgh-po POST-OFFICE)
	 (objects-are pgh-airport bos-airport AIRPORT)
	 (objects-are pittsburgh boston CITY)
	 )
	((at-obj package1 pgh-po)
	 (at-obj package2 bos-po)
	 (at-airplane airplane1 pgh-airport)
	 (at-airplane airplane2 pgh-airport)
	 (at-truck pgh-truck pgh-po)
	 (at-truck bos-truck1 bos-po)
	 (at-truck bos-truck2 bos-po)
	 (part-of bos-truck1 boston)
	 (part-of bos-truck2 boston)
	 (part-of pgh-truck pittsburgh)
	 (loc-at pgh-po pittsburgh)
	 (loc-at pgh-airport pittsburgh)
	 (loc-at bos-po boston)
	 (loc-at bos-airport boston)
	 (same-city bos-po bos-airport)
	 (same-city pgh-po pgh-airport)
	 (same-city pgh-airport pgh-po)
	 (same-city bos-airport bos-po)
	 )
	)
       )
      :sender ProdigyClient)
  
  "Used to test the behavior of the PRODIGY/Agent."
  )




(defparameter
    *test-performative*

    '(standby :content 
      (achieve 
       :time-bound 1000
       :content 
       (((at-obj package1 bos-po)
	 (at-obj package2 seattle-po)
	 )
	((objects-are package1 package2 package3 package4 OBJECT)
	 (objects-are pgh-truck bos-truck cleveland-truck seattle-truck TRUCK)
	 (objects-are airplane1 airplane2 airplane3 airplane4 AIRPLANE)
	 (objects-are bos-po pgh-po cleveland-po seattle-po POST-OFFICE)
	 (objects-are pgh-airport bos-airport cleveland-airport seattle-airport AIRPORT)
	 (objects-are pittsburgh boston cleveland seattle CITY)
	 )
	((at-obj package1 pgh-po)
	 (at-obj package2 pgh-po)
	 (at-obj package3 pgh-po)
	 (at-obj package4 pgh-po)
	 (at-airplane airplane1 pgh-airport)
	 (at-airplane airplane2 pgh-airport)
	 (at-airplane airplane3 pgh-airport)
	 (at-airplane airplane4 pgh-airport)
	 (at-truck pgh-truck pgh-po)
	 (at-truck bos-truck bos-po)
	 (at-truck cleveland-truck cleveland-po)
	 (at-truck seattle-truck seattle-po)
	 (part-of bos-truck boston)
	 (part-of pgh-truck pittsburgh)
	 (part-of cleveland-truck cleveland)
	 (part-of seattle-truck seattle)
	 (loc-at pgh-po pittsburgh)
	 (loc-at pgh-airport pittsburgh)
	 (loc-at bos-po boston)
	 (loc-at bos-airport boston)
	 (loc-at cleveland-po cleveland)
	 (loc-at cleveland-airport cleveland)
	 (loc-at seattle-po seattle)
	 (loc-at seattle-airport seattle)
	 (same-city bos-po bos-airport)
	 (same-city pgh-po pgh-airport)
	 (same-city cleveland-po cleveland-airport)
	 (same-city bos-po bos-airport)
	 (same-city pgh-airport pgh-po)
	 (same-city bos-airport bos-po)
	 (same-city cleveland-airport cleveland-po)
	 (same-city seattle-airport seattle-po))
	)
       )
      :sender ProdigyClient)
  
  "The manycities example"
  )
















