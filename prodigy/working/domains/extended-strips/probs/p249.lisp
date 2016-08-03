(setf (current-problem)
  (create-problem
    (name p249)
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
          (inroom keyB rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (carriable boxB)
          (inroom boxB rmB)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmD)
))
    (goal
      (and
          (inroom boxC rmB)
          (inroom boxD rmB)
          (inroom boxB rmB)
          (inroom boxA rmA)
))))