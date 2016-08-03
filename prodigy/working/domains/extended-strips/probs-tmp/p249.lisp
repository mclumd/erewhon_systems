(setf (current-problem)
  (create-problem
    (name p249)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (locked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxC)
          (inroom boxC rmC)
          (carriable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxC)
          (inroom boxA rmA)
))))