(setf (current-problem)
  (create-problem
    (name p724)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmA)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxC)
          (inroom boxC rmA)
          (carriable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmD)
))))