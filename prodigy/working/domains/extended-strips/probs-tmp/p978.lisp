(setf (current-problem)
  (create-problem
    (name p978)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxA)
          (inroom robot rmD)
))))