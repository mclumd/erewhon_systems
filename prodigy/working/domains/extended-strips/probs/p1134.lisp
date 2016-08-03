(setf (current-problem)
  (create-problem
    (name p1134)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxD)
          (inroom boxD rmB)
          (carriable boxB)
          (inroom boxB rmB)
          (carriable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxD rmC)
          (inroom boxB rmA)
          (inroom boxA rmD)
))))