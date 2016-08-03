(setf (current-problem)
  (create-problem
    (name p280)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmD)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmD)
))))