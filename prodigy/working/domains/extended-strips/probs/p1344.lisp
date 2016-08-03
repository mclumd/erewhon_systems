(setf (current-problem)
  (create-problem
    (name p1344)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmA)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxC)
          (inroom boxC rmD)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxB rmC)
          (inroom boxC rmD)
          (holding keyB)
))))