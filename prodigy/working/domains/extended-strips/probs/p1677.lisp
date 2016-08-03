(setf (current-problem)
  (create-problem
    (name p1677)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmB)
          (carriable boxD)
          (inroom boxD rmB)
          (carriable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmB)
          (inroom boxD rmD)
))))