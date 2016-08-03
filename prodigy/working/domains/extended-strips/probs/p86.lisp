(setf (current-problem)
  (create-problem
    (name p86)
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
          (inroom keyB rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (carriable boxA)
          (inroom boxA rmB)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxD rmD)
          (inroom boxA rmA)
))))