(setf (current-problem)
  (create-problem
    (name p517)
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
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxA)
          (inroom boxA rmC)
          (carriable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmD)
))))