(setf (current-problem)
  (create-problem
    (name p671)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmD)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxA rmB)
          (holding keyD)
          (dr-open drB)
          (unlocked drB)
))))