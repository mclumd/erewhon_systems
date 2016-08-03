(setf (current-problem)
  (create-problem
    (name p522)
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
          (inroom keyB rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmA)
          (inroom boxA rmD)
))))