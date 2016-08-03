(setf (current-problem)
  (create-problem
    (name p1679)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
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
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmD)
          (inroom robot rmA)
          (holding keyA)
))))