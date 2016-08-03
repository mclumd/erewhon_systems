
(setf result '(
   (time 1.067)
   (nodes 21)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((in-same-city pgh-po pgh-airport pittsburgh) (in-same-city pgh-airport pgh-po pittsburgh)
              (drive-truck pgh-truck pgh-airport pgh-po) (load-truck package1 pgh-truck pgh-po)))))

(setf problem-solved 
   "/afs/cs/project/prodigy-1/mcox/domains/logistics/probs/p133-old2")
(setf goal '((inside-truck package1 pgh-truck)))

(setf case-objects '((object-is package1 object) (object-is pgh-truck truck) (object-is airplane1 airplane)
                     (object-is pgh-po post-office) (objects-are pgh-airport bos-airport airport)
                     (objects-are pittsburgh boston city)))

(setf insts-to-vars '(
   (package1 . <object.66>) 
   (pgh-truck . <truck.22>) 
   (airplane1 . <airplane.65>) 
   (pgh-po . <post-office.72>) 
   (pgh-airport . <airport.20>) (bos-airport . <airport.6>) 
   (pittsburgh . <city.85>) (boston . <city.69>) 
))

(setf footprint-by-goal '(
   ((inside-truck package1 pgh-truck) (loc-at pgh-airport pittsburgh) (loc-at pgh-po pittsburgh)
    (at-truck pgh-truck pgh-airport) (at-obj package1 pgh-po))))
