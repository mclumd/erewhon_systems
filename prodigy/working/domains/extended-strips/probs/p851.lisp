(setf (current-problem)
  (create-problem
    (name p851)
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
          (unlocked drA)
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxC)
          (inroom boxC rmC)
          (pushable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (inroom boxA rmA)
          (inroom boxD rmD)
          (inroom boxC rmA)
          (inroom boxB rmA)
          (inroom robot rmD)
))))