(setf (current-problem)
  (create-problem
    (name p734)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (carriable boxD)
          (holding boxD)
          (carriable boxC)
          (inroom boxC rmD)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxC)
          (inroom boxD rmC)
          (inroom boxA rmA)
          (inroom boxB rmA)
))))