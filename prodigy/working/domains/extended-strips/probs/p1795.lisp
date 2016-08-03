(setf (current-problem)
  (create-problem
    (name p1795)
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
          (inroom keyA rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmD)
))
    (goal
      (and
          (holding boxA)
          (inroom boxD rmA)
))))