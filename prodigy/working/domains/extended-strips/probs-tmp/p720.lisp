(setf (current-problem)
  (create-problem
    (name p720)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxA rmB)
          (inroom boxC rmA)
          (inroom boxD rmD)
))))