(setf (current-problem)
  (create-problem
    (name p37)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (carriable boxB)
          (holding boxB)
          (carriable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (inroom boxA rmC)
))))