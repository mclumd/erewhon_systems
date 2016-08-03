(setf (current-problem)
  (create-problem
    (name p1652)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmB)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxD rmC)
          (inroom boxC rmB)
          (inroom boxA rmC)
          (inroom boxB rmB)
          (inroom robot rmA)
))))