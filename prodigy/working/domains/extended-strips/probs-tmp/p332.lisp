(setf (current-problem)
  (create-problem
    (name p332)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxC)
          (inroom boxC rmB)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmB)
          (inroom boxC rmC)
))))