(setf (current-problem)
  (create-problem
    (name p483)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmA)
          (carriable boxA)
          (inroom boxA rmB)
          (pushable boxD)
          (inroom boxD rmA)
          (carriable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxD rmC)
          (inroom boxB rmB)
          (inroom boxC rmB)
))))