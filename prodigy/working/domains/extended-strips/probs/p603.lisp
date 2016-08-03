(setf (current-problem)
  (create-problem
    (name p603)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmA)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxC)
          (inroom boxC rmD)
          (pushable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (holding boxC)
          (inroom boxD rmB)
          (inroom boxA rmB)
          (inroom boxB rmA)
))))