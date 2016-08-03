(setf (current-problem)
  (create-problem
    (name p996)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmA)
          (carriable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmB)
          (inroom boxA rmA)
          (inroom robot rmB)
))))