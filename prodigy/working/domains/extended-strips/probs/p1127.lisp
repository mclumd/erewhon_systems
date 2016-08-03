(setf (current-problem)
  (create-problem
    (name p1127)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (pushable boxD)
          (inroom boxD rmD)
          (pushable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmC)
          (inroom boxA rmB)
))))