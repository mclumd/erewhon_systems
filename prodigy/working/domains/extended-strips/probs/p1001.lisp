(setf (current-problem)
  (create-problem
    (name p1001)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmB)
          (carriable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmC)
))))