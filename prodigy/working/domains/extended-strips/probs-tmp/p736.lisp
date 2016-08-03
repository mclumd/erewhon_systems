(setf (current-problem)
  (create-problem
    (name p736)
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
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
          (carriable boxB)
          (inroom boxB rmD)
          (pushable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxC rmC)
          (inroom boxB rmB)
))))