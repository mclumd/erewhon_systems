(define (domain logistics)
	(:requirements :strips) 
	(:predicates 	(obj ?obj)
								(truck ?truck ?city)
								(location ?loc)
								(airplane ?airplane)
								(city ?city)
								(airport ?airport)
								(obj-at ?obj ?loc)
								(in-truck ?obj ?truck)
								(in-airplane ?obj ?plane)
								(in-city ?loc ?city)
								(truck-at ?truck ?loc)
								(airplane-at ?plane ?airport))

	(:action drive-truck 
						 :parameters
						 (?t ?l1 ?l2 ?c)
						 :precondition
						 (and (truck ?t ?c) 
									(in-city ?l1 ?c)
									(in-city ?l2 ?c)
									(truck-at ?t ?l1))
						 :effect
						 (and (not (truck-at ?t ?l1)) 
									(truck-at ?t ?l2)))

	(:action fly-airplane 
					 :parameters
					 (?plane ?a1 ?a2)
					 :precondition
					 (and (airport ?a1)
								(airport ?a2)
								(airplane ?plane)
								(airplane-at ?plane ?a1))
					 :effect
					 (and (not (airplane-at ?plane ?a1)) 
								(airplane-at ?plane ?a2)))

	(:action load-truck 
					 :parameters
					 (?o ?t ?l)
					 :precondition
					 (and (obj-at ?o ?l)
								(truck-at ?t ?l))
					 :effect
					 (and (not (obj-at ?o ?l))
								(in-truck ?o ?t)))

	(:action unload-truck 
					 :parameters
					 (?o ?t ?l)
					 :precondition
					 (and (in-truck ?o ?t)
								(truck-at ?t ?l))
					 :effect
					 (and (not (in-truck ?o ?t))
								(obj-at ?o ?l)))

	(:action load-airplane 
					 :parameters
					 (?o ?plane ?l)
					 :precondition	 
					 (and (airplane ?plane)
								(airport ?l)
								(airplane-at ?plane ?l)
								(obj-at ?o ?l))
					 :effect
					 (and (not (obj-at ?o ?l))
								(in-airplane ?o ?plane)))

	(:action unload-airplane
					 :parameters
					 (?o ?plane ?l)
					 :precondition
					 (and (airplane ?plane)
								(airport ?l)
								(airplane-at ?plane ?l)
								(in-airplane ?o ?plane))
					 :effect
					 (and (not (in-airplane ?o ?plane))
								(obj-at ?o ?l))))
