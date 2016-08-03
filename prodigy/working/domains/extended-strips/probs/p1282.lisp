(setf (current-problem)
  (create-problem
    (name p1282)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom robot rmB)
          (holding keyB)
          (inroom keyA rmA)
          (dr-open drB)
          (unlocked drB)
))))