(setf (current-problem)
  (create-problem
    (name p1902)
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
          (inroom keyB rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (holding boxD)
          (inroom boxB rmC)
))))