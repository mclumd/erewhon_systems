(setf (current-problem)
  (create-problem
    (name p897)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmC)
          (carriable boxB)
          (holding boxB)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxD)
          (inroom boxD rmC)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmC)
          (inroom boxC rmD)
          (inroom boxD rmB)
          (dr-closed drA)
          (unlocked drA)
))))