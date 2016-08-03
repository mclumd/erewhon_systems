(setf (current-problem)
  (create-problem
    (name p371)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (carriable boxA)
          (inroom boxA rmA)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxB rmB)
          (inroom boxC rmB)
          (inroom boxA rmB)
          (dr-open drB)
          (unlocked drB)
))))