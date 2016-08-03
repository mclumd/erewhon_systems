(setf (current-problem)
  (create-problem
    (name p39)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxA rmA)
          (dr-open drA)
          (unlocked drA)
          (dr-open drB)
          (unlocked drB)
          (holding keyB)
          (inroom robot rmD)
))))