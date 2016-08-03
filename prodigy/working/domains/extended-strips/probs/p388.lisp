(setf (current-problem)
  (create-problem
    (name p388)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmC)
          (inroom boxC rmA)
))))