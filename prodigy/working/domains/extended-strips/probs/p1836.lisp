(setf (current-problem)
  (create-problem
    (name p1836)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
          (locked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (locked drD)
          (dr-closed drD)
          (is-key keyD drD)
          (carriable keyD)
          (inroom keyD rmC)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (carriable boxD)
          (inroom boxD rmA)
          (carriable boxC)
          (inroom boxC rmD)
          (pushable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxA)
))))