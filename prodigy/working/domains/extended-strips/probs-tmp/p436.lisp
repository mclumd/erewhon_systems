(setf (current-problem)
  (create-problem
    (name p436)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom robot rmB)
          (dr-closed drB)
          (unlocked drB)
))))