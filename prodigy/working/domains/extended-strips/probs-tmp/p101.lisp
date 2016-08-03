(setf (current-problem)
  (create-problem
    (name p101)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (pushable boxC)
          (inroom boxC rmD)
          (carriable boxD)
          (inroom boxD rmD)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxB rmB)
          (inroom boxD rmA)
          (inroom boxA rmC)
))))