(setf (current-problem)
  (create-problem
    (name p660)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmC)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxD)
          (inroom boxD rmD)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxC rmA)
))))