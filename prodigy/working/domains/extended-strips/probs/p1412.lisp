(setf (current-problem)
  (create-problem
    (name p1412)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
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
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (unlocked drD)
          (dr-open drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxA)
))))