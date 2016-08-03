(setf (current-problem)
  (create-problem
    (name p843)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxD)
          (inroom boxD rmB)
          (pushable boxA)
          (inroom boxA rmC)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (holding boxC)
))))