(setf (current-problem)
  (create-problem
    (name p1883)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxC)
          (inroom boxC rmD)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmB)
))))