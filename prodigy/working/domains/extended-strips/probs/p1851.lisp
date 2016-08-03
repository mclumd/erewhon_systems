(setf (current-problem)
  (create-problem
    (name p1851)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmD)
          (carriable boxB)
          (holding boxB)
          (pushable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxC rmD)
          (inroom boxA rmB)
          (inroom boxB rmA)
          (inroom boxD rmB)
          (inroom robot rmC)
))))