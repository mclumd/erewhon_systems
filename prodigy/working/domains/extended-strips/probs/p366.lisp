(setf (current-problem)
  (create-problem
    (name p366)
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
          (unlocked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmB)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxC rmC)
))))