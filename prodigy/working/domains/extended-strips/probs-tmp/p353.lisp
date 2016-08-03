(setf (current-problem)
  (create-problem
    (name p353)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmA)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmA)
          (inroom boxC rmB)
          (inroom robot rmB)
))))