(setf (current-problem)
  (create-problem
    (name p740)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmD)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmD)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmA)
))))