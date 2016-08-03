(setf (current-problem)
  (create-problem
    (name p168)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmA)
          (inroom boxC rmD)
          (inroom boxB rmD)
))))