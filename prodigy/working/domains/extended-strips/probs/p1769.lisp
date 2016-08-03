(setf (current-problem)
  (create-problem
    (name p1769)
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
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
          (carriable boxB)
          (inroom boxB rmB)
          (carriable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxC rmA)
          (inroom boxB rmA)
          (inroom boxA rmA)
          (inroom robot rmB)
))))