(setf (current-problem)
  (create-problem
    (name p876)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
          (dr-closed drA)
          (locked drA)
          (inroom robot rmC)
))))