(setf (current-problem)
  (create-problem
    (name p48)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmC)
          (inroom robot rmC)
          (carriable boxC)
          (holding boxC)
          (carriable boxD)
          (inroom boxD rmC)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (holding boxD)
          (inroom boxA rmC)
          (inroom boxB rmC)
          (inroom boxC rmB)
          (holding keyC)
))))