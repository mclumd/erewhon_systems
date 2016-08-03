(setf (current-problem)
  (create-problem
    (name p1919)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxA)
          (inroom keyD rmD)
          (inroom robot rmA)
          (dr-open drA)
          (unlocked drA)
))))