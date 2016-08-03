(setf (current-problem)
  (create-problem
    (name p1744)
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
          (inroom keyB rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmB)
          (carriable boxB)
          (holding boxB)
          (pushable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmD)
          (carriable boxC)
          (inroom boxC rmD)
))
    (goal
      (and
          (inroom boxC rmB)
          (inroom boxB rmC)
))))