(create-problem-space 'GUIworld :current t)

(ptype-of WINDOW :top-type)
(ptype-of SCREEN :top-type)
(ptype-of QUADRANT :top-type)


(OPERATOR ICONIFY
  (params <ob>)
  (preconds 
   ((<ob> WINDOW) (<q> QUADRANT))
   (and (in <ob> <q>)
   (active <ob>)
   (visible <ob>)
   (~ (icon <ob>))))
  (effects 
   () ; no vars need genenerated in effects list
   ((del (visible <ob>))
    (del (active <ob>))
    (del (in <ob> <q>))
    (add (empty <q>))
    (add (icon <ob>)))))
