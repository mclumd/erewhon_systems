(setf (current-problem)
  (create-problem
    (name p726)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (holding boxA)
))))