(setf (current-problem)
  (create-problem
    (name p598)
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
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxD)
          (inroom boxD rmD)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxD rmA)
          (inroom boxB rmC)
          (inroom boxC rmA)
          (inroom boxA rmC)
))))