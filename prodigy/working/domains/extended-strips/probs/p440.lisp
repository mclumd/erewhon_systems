(setf (current-problem)
  (create-problem
    (name p440)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxD)
          (inroom boxD rmD)
          (pushable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxC rmC)
))))