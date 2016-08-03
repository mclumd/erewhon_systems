(setf (current-problem)
  (create-problem
    (name p811)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmC)
          (pushable boxB)
          (inroom boxB rmD)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmD)
))
    (goal
      (and
          (holding boxC)
          (inroom boxA rmA)
          (inroom boxD rmD)
          (inroom boxB rmC)
))))