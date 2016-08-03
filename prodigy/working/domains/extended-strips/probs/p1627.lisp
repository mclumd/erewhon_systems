(setf (current-problem)
  (create-problem
    (name p1627)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmD)
          (carriable boxB)
          (holding boxB)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxC rmD)
          (inroom boxA rmB)
          (dr-closed drB)
          (unlocked drB)
))))