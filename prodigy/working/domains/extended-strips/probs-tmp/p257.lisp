(setf (current-problem)
  (create-problem
    (name p257)
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
          (inroom keyA rmA)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmB)
          (pushable boxD)
          (inroom boxD rmB)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (inroom boxC rmA)
          (inroom boxA rmD)
          (inroom boxB rmD)
          (inroom boxD rmD)
))))