(setf (current-problem)
  (create-problem
    (name p1507)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmB)
          (dr-to-rm drA rmD)
          (connects drA rmB rmD)
          (connects drA rmD rmB)
          (unlocked drA)
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmA)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmB)
))))