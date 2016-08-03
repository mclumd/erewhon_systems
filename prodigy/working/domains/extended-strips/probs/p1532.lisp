(setf (current-problem)
  (create-problem
    (name p1532)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (inroom boxD rmA)
          (inroom boxA rmD)
          (inroom boxB rmD)
))))