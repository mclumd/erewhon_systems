(setf (current-problem)
  (create-problem
    (name p642)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmB)
          (carriable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmB)
          (inroom boxA rmB)
          (inroom robot rmD)
))))