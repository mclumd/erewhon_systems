(setf (current-problem)
  (create-problem
    (name p1401)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxC)
          (inroom boxC rmB)
          (carriable boxD)
          (inroom boxD rmA)
          (pushable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmC)
          (inroom boxD rmB)
))))