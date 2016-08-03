(setf (current-problem)
  (create-problem
    (name p24)
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
          (inroom keyA rmA)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxD rmB)
          (inroom boxC rmC)
))))