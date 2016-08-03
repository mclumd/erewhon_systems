(setf (current-problem)
  (create-problem
    (name p943)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmA)
          (pushable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxB rmB)
          (inroom boxC rmC)
))))