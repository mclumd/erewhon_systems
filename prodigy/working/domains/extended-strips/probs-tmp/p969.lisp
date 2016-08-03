(setf (current-problem)
  (create-problem
    (name p969)
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
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmD)
          (carriable boxB)
          (holding boxB)
          (carriable boxA)
          (inroom boxA rmC)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxD)
          (inroom boxD rmD)
))
    (goal
      (and
          (inroom boxA rmC)
))))