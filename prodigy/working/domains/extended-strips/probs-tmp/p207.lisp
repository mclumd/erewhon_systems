(setf (current-problem)
  (create-problem
    (name p207)
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
          (inroom keyB rmC)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxA)
          (inroom boxA rmA)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmD)
))))