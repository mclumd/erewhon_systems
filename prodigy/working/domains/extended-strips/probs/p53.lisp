(setf (current-problem)
  (create-problem
    (name p53)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmC)
          (carriable boxB)
          (holding boxB)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmB)
          (inroom boxC rmA)
))))