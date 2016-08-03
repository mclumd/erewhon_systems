(setf (current-problem)
  (create-problem
    (name p1167)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
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
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (carriable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmC)
          (inroom boxD rmA)
          (inroom boxC rmC)
))))