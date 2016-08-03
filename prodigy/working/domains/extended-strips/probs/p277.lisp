(setf (current-problem)
  (create-problem
    (name p277)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxB rmD)
          (inroom boxA rmB)
))))