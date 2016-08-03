(setf (current-problem)
  (create-problem
    (name p1871)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmA)
          (inroom boxA rmA)
))))