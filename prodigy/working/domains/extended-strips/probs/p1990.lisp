(setf (current-problem)
  (create-problem
    (name p1990)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmC)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxD)
          (inroom boxD rmC)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmA)
          (inroom boxC rmA)
))))