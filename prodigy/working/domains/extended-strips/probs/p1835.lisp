(setf (current-problem)
  (create-problem
    (name p1835)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmB)
          (carriable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxB rmD)
          (inroom robot rmC)
          (dr-open drA)
          (unlocked drA)
))))