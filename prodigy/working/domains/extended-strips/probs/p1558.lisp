(setf (current-problem)
  (create-problem
    (name p1558)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyD drA)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (unlocked drD)
          (dr-open drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmD)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
          (inroom robot rmA)
))))