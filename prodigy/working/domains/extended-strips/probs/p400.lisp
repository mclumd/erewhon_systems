(setf (current-problem)
  (create-problem
    (name p400)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
          (inroom robot rmC)
))))