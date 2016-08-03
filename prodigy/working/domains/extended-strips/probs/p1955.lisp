(setf (current-problem)
  (create-problem
    (name p1955)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxD)
          (inroom boxD rmA)
          (carriable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (inroom boxD rmA)
          (inroom boxC rmC)
          (inroom boxB rmC)
))))