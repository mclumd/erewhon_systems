(setf (current-problem)
  (create-problem
    (name p376)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmD)
          (pushable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxB rmA)
))))