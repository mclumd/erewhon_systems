(setf (current-problem)
  (create-problem
    (name p178)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
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
          (is-key keyD drA)
          (carriable keyD)
          (inroom keyD rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (unlocked drD)
          (dr-closed drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmC)
          (inroom robot rmC)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
          (inroom keyD rmA)
))))