(setf (current-problem)
  (create-problem
    (name p1775)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (carriable boxB)
          (holding boxB)
          (pushable boxA)
          (inroom boxA rmB)
          (carriable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmD)
          (inroom boxC rmB)
          (holding keyB)
))))