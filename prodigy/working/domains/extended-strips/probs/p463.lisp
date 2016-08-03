(setf (current-problem)
  (create-problem
    (name p463)
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
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmB)
          (pushable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxC rmA)
          (inroom boxB rmD)
          (inroom robot rmD)
          (inroom keyB rmB)
))))