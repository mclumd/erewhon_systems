(setf (current-problem)
  (create-problem
    (name p703)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
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
          (carriable boxD)
          (holding boxD)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxC)
          (inroom boxC rmD)
))
    (goal
      (and
          (inroom boxC rmB)
          (inroom boxA rmA)
          (inroom boxB rmC)
          (inroom boxD rmD)
))))