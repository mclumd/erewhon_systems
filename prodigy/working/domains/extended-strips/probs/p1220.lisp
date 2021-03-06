(setf (current-problem)
  (create-problem
    (name p1220)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (carriable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxA rmB)
          (dr-closed drB)
          (locked drB)
          (inroom keyA rmD)
          (holding keyB)
))))