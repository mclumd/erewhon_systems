(setf (current-problem)
  (create-problem
    (name p1517)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmC)
          (pushable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmD)
          (inroom boxC rmB)
))))