(setf (current-problem)
  (create-problem
    (name p184)
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
          (inroom keyA rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (unlocked drD)
          (dr-open drD)
          (is-key keyD drD)
          (carriable keyD)
          (inroom keyD rmD)
          (inroom robot rmD)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmC)
          (carriable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxA rmA)
          (inroom boxB rmA)
          (inroom keyD rmB)
          (dr-open drB)
          (unlocked drB)
))))