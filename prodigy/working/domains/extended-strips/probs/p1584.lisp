(setf (current-problem)
  (create-problem
    (name p1584)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmC)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmD)
          (carriable boxC)
          (inroom boxC rmD)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxB rmC)
          (inroom boxD rmB)
))))