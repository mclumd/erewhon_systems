(setf (current-problem)
  (create-problem
    (name p1723)
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
          (unlocked drA)
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmC)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
          (dr-closed drA)
          (unlocked drA)
          (dr-open drB)
          (unlocked drB)
))))