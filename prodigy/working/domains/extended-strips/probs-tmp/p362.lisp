(setf (current-problem)
  (create-problem
    (name p362)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (locked drD)
          (dr-closed drD)
          (is-key keyD drD)
          (carriable keyD)
          (inroom keyD rmC)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxA rmD)
))))