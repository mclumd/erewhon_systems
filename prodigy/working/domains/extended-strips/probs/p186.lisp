(setf (current-problem)
  (create-problem
    (name p186)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmD)
          (carriable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmC)
          (inroom keyB rmC)
          (inroom robot rmA)
))))