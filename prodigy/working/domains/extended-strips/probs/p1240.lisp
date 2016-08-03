(setf (current-problem)
  (create-problem
    (name p1240)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxC)
          (inroom boxC rmC)
          (carriable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxC rmD)
          (inroom boxB rmC)
          (inroom boxA rmA)
))))