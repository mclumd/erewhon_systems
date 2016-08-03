(setf (current-problem)
  (create-problem
    (name p108)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxC)
          (inroom boxC rmA)
          (pushable boxD)
          (inroom boxD rmD)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxC rmB)
          (inroom boxD rmC)
          (inroom boxA rmA)
          (inroom boxB rmD)
))))