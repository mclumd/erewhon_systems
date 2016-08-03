(setf (current-problem)
  (create-problem
    (name p1591)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmB)
          (dr-to-rm drA rmD)
          (connects drA rmB rmD)
          (connects drA rmD rmB)
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxB rmA)
))))