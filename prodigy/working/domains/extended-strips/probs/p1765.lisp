(setf (current-problem)
  (create-problem
    (name p1765)
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
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmC)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (unlocked drD)
          (dr-closed drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmD)
          (inroom robot rmD)
          (carriable boxD)
          (holding boxD)
          (pushable boxB)
          (inroom boxB rmA)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmA)
          (inroom boxC rmD)
))))