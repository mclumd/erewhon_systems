(setf (current-problem)
  (create-problem
    (name p276)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmB)
          (carriable boxC)
          (inroom boxC rmC)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmB)
          (inroom boxB rmB)
))))