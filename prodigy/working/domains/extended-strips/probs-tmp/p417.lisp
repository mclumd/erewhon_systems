(setf (current-problem)
  (create-problem
    (name p417)
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
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmB)
          (inroom boxA rmC)
))))