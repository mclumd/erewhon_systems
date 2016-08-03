(setf (current-problem)
  (create-problem
    (name p547)
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
          (inroom keyA rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmC)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmC)
          (inroom boxD rmD)
))))