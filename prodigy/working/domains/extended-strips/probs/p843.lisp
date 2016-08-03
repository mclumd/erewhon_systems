(setf (current-problem)
  (create-problem
    (name p843)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmC)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (inroom boxD rmD)
))))