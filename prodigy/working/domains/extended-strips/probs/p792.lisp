(setf (current-problem)
  (create-problem
    (name p792)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxD rmA)
          (inroom boxA rmD)
          (inroom boxC rmD)
))))