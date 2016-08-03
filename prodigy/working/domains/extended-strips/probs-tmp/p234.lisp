(setf (current-problem)
  (create-problem
    (name p234)
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
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxC)
          (inroom boxC rmC)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmB)
          (inroom boxA rmD)
))))