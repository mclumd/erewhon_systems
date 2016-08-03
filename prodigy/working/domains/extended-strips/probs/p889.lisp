(setf (current-problem)
  (create-problem
    (name p889)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmC)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (inroom boxA rmD)
          (dr-open drA)
          (unlocked drA)
          (dr-closed drB)
          (locked drB)
          (inroom keyB rmA)
          (inroom robot rmD)
))))