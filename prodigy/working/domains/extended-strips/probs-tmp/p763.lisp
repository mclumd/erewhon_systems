(setf (current-problem)
  (create-problem
    (name p763)
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
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxC rmC)
))))