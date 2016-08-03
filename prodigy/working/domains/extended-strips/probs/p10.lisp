(setf (current-problem)
  (create-problem
    (name p10)
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
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (carriable boxD)
          (holding boxD)
          (pushable boxC)
          (inroom boxC rmA)
          (carriable boxB)
          (inroom boxB rmC)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (inroom boxD rmC)
          (inroom boxC rmA)
          (inroom boxA rmA)
          (inroom boxB rmA)
))))