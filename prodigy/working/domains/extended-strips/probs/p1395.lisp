(setf (current-problem)
  (create-problem
    (name p1395)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (unlocked drD)
          (dr-closed drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmD)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxB rmC)
          (inroom boxA rmB)
          (dr-open drC)
          (unlocked drC)
))))