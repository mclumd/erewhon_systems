(setf (current-problem)
  (create-problem
    (name p791)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (carriable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxB rmA)
          (inroom robot rmC)
))))