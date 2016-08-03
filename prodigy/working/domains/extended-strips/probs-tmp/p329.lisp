(setf (current-problem)
  (create-problem
    (name p329)
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
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (carriable boxB)
          (holding boxB)
          (carriable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmA)
          (carriable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmA)
          (inroom boxC rmA)
))))