(setf (current-problem)
  (create-problem
    (name p18)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxD)
          (inroom boxD rmD)
          (pushable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxD rmB)
          (inroom boxA rmA)
))))