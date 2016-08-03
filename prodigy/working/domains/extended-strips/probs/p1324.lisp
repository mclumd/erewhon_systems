(setf (current-problem)
  (create-problem
    (name p1324)
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
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (pushable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmC)
          (inroom boxA rmC)
          (dr-open drA)
          (unlocked drA)
))))