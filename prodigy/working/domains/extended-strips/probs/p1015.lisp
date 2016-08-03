(setf (current-problem)
  (create-problem
    (name p1015)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxB rmB)
          (inroom boxA rmB)
          (dr-open drB)
          (unlocked drB)
          (inroom robot rmA)
          (holding keyB)
))))