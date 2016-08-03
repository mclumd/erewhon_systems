(setf (current-problem)
  (create-problem
    (name p819)
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
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmB)
          (carriable boxD)
          (inroom boxD rmB)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (holding boxD)
          (inroom boxC rmC)
          (inroom boxB rmD)
          (inroom boxA rmA)
))))