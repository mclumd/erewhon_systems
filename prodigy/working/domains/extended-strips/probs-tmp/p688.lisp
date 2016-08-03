(setf (current-problem)
  (create-problem
    (name p688)
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
          (inroom keyB rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (pushable boxB)
          (inroom boxB rmC)
          (carriable boxA)
          (inroom boxA rmB)
          (carriable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmD)
          (inroom boxC rmA)
))))