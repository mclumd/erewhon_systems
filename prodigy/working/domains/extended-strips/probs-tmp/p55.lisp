(setf (current-problem)
  (create-problem
    (name p55)
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
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (inroom boxA rmD)
          (dr-open drB)
          (unlocked drB)
          (inroom keyA rmD)
))))