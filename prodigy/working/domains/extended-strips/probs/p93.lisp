(setf (current-problem)
  (create-problem
    (name p93)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
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
          (inroom keyB rmA)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (inroom boxA rmC)
          (holding keyB)
          (inroom robot rmB)
          (inroom keyC rmC)
))))