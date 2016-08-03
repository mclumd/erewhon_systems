(setf (current-problem)
  (create-problem
    (name p1631)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
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
          (inroom keyB rmD)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxB)
          (inroom boxB rmC)
          (carriable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmA)
          (inroom boxB rmC)
))))