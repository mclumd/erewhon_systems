(setf (current-problem)
  (create-problem
    (name p1422)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmD)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (unlocked drD)
          (dr-open drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmB)
          (inroom robot rmA)
          (carriable boxA)
          (holding boxA)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxA rmA)
))))