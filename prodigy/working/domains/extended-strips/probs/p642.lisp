(setf (current-problem)
  (create-problem
    (name p642)
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
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmA)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxD)
          (inroom boxC rmD)
          (inroom boxA rmA)
))))