(setf (current-problem)
  (create-problem
    (name p429)
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
          (inroom keyB rmC)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmA)
))))