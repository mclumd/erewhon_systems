(setf (current-problem)
  (create-problem
    (name p334)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
          (carriable boxB)
          (inroom boxB rmA)
          (pushable boxC)
          (inroom boxC rmC)
          (pushable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (inroom boxD rmB)
          (inroom boxB rmD)
          (inroom boxA rmD)
))))