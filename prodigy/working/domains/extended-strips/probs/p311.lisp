(setf (current-problem)
  (create-problem
    (name p311)
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
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmD)
          (carriable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxC rmD)
          (inroom boxB rmD)
          (holding keyA)
))))