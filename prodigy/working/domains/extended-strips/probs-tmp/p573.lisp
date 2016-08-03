(setf (current-problem)
  (create-problem
    (name p573)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxC rmB)
          (inroom boxA rmD)
          (inroom robot rmA)
))))