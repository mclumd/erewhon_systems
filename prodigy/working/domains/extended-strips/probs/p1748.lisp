(setf (current-problem)
  (create-problem
    (name p1748)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (inroom keyA rmD)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxB rmD)
          (dr-closed drA)
          (unlocked drA)
))))