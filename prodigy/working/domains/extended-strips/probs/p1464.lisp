(setf (current-problem)
  (create-problem
    (name p1464)
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
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmB)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmC)
          (inroom boxA rmD)
          (holding keyA)
))))