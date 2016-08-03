(setf (current-problem)
  (create-problem
    (name p718)
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
          (inroom robot rmD)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmB)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxD)
          (inroom boxD rmD)
          (carriable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmC)
          (inroom boxD rmC)
          (inroom boxA rmC)
))))