(setf (current-problem)
  (create-problem
    (name p808)
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
          (unlocked drA)
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmA)
          (inroom boxB rmD)
))))