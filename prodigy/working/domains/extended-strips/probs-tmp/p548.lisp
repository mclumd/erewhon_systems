(setf (current-problem)
  (create-problem
    (name p548)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (inroom boxA rmA)
))))