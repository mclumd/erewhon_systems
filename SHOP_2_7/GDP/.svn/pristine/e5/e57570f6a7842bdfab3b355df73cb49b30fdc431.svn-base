(in-package :shop2)

(defdomain logistics
					 ((:operator (!drive-truck ?t ?l1 ?l2 ?c)
											 ((truck ?t ?c) 
												(in-city ?l1 ?c)
												(in-city ?l2 ?c)
												(truck-at ?t ?l1))
											 ((truck-at ?t ?l1))
											 ((truck-at ?t ?l2)))

						(:operator (!fly-airplane ?plane ?a1 ?a2)
											 ((airport ?a1)
												(airport ?a2)
												(airplane ?plane)
												(airplane-at ?plane ?a1))
											 ((airplane-at ?plane ?a1))
											 ((airplane-at ?plane ?a2)))

						(:operator (!load-truck ?o ?t ?l)
											 ((obj-at ?o ?l)
												(truck-at ?t ?l))
											 ((obj-at ?o ?l))
											 ((in-truck ?o ?t)))

						(:operator (!unload-truck ?o ?t ?l)
											 ((in-truck ?o ?t)
												(truck-at ?t ?l))
											 ((in-truck ?o ?t))
											 ((obj-at ?o ?l)))

						(:operator (!load-airplane ?o ?plane ?l)
											 ((airplane ?plane)
												(airport ?l)
												(airplane-at ?plane ?l)
												(obj-at ?o ?l))
											 ((obj-at ?o ?l))
											 ((in-airplane ?o ?plane)))

						(:operator (!unload-airplane ?o ?plane ?l)
											 ((airplane ?plane)
												(airport ?l)
												(airplane-at ?plane ?l)
												(in-airplane ?o ?plane))
											 ((in-airplane ?o ?plane))
											 ((obj-at ?o ?l)))

						;; this rule helps achieve moving package around 
						;; within the same city using the truck belonging
						;; to that city
						(:gdr (move-obj-within-city ?o ?l1 ?l2 ?c ?t ?l3)
									((obj-at ?o ?l2))
									((obj-at ?o ?l1)
									 (in-city ?l1 ?c)
									 (in-city ?l2 ?c)
									 (truck ?t ?c)
									 (truck-at ?t ?l3))
									((truck-at ?t ?l1)
									 (in-truck ?o ?t)
									 (truck-at ?t ?l2)))

						;; this rule helps achieve moving package between cities
						;; by airplane. It decomposes the goal of delivering package
						;; to location l2 into the goals of getting package to 
						;; airport of current city, airport of destination city and 
						;; the final goal
						(:gdr (move-obj-between-cities ?o ?l1 ?l2 ?a1 ?a2 ?c1 ?c2)
									((obj-at ?o ?l2))
									((obj-at ?o ?l1)
									 (in-city ?l1 ?c1)
									 (in-city ?l2 ?c2)
									 (different ?c1 ?c2)
									 (airport ?a1)
									 (airport ?a2)
									 (in-city ?a1 ?c1)
									 (in-city ?a2 ?c2))
									((obj-at ?o ?a1)
									 (obj-at ?o ?a2)))

						;; this rule achieves the goal of delivering package at 
						;; the destination airport. Decomposes the goal into
						;; the goals of getting airplane to origin airport, 
						;; getting object into airplane, getting airplane to
						;; final destination and the final goal
						(:gdr (move-obj-between-airports ?o ?a1 ?a2 ?plane)
									((obj-at ?o ?a2))
									((obj-at ?o ?a1)
									 (airport ?a1)
									 (airport ?a2)
									 (airplane ?plane))
									((airplane-at ?plane ?a1)
									 (in-airplane ?o ?plane)
									 (airplane-at ?plane ?a2)))
						
						(:- (different ?x ?y) ((not (same ?x ?y))))
						(:- (same ?x ?x) nil)
						))



