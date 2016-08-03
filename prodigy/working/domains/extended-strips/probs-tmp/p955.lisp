(setf (current-problem)
  (create-problem
    (name p955)
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
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmC)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxB rmB)
          (inroom boxC rmA)
          (inroom keyA rmB)
))))