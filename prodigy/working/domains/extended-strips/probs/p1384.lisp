(setf (current-problem)
  (create-problem
    (name p1384)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmD)
          (carriable boxD)
          (holding boxD)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmA)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmD)
))))