(setf (current-problem)
  (create-problem
    (name p711)
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
          (inroom keyB rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxC rmD)
          (inroom boxA rmA)
))))