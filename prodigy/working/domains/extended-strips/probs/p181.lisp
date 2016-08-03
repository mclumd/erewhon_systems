(setf (current-problem)
  (create-problem
    (name p181)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmA)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxC)
          (inroom boxC rmD)
))
    (goal
      (and
          (inroom boxA rmA)
          (inroom boxC rmD)
))))