
(setf result '(
   (time 0.4)
   (nodes 12)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((in-same-city pgh-po pgh-airport pittsburgh) (in-same-city pgh-airport pgh-po pittsburgh)
              (fly-airplane airplane1 bos-airport pgh-airport) (load-airplane package1 airplane1 pgh-airport)))))

(setf problem-solved 
   "/afs/cs/project/prodigy-1/mcox/domains/logistics/probs/p133-old1")
(setf goal '((inside-airplane package1 airplane1)))

(setf case-objects '((object-is package1 object) (object-is pgh-truck truck) (object-is airplane1 airplane)
                     (object-is pgh-po post-office) (objects-are pgh-airport bos-airport airport)
                     (objects-are pittsburgh boston city)))

(setf insts-to-vars '(
   (package1 . <object.81>) 
   (pgh-truck . <truck.50>) 
   (airplane1 . <airplane.37>) 
   (pgh-po . <post-office.64>) 
   (pgh-airport . <airport.1>) (bos-airport . <airport.9>) 
   (pittsburgh . <city.86>) (boston . <city.29>) 
))

(setf footprint-by-goal '(
   ((inside-airplane package1 airplane1) (at-obj package1 pgh-airport) (at-airplane airplane1 bos-airport))))
