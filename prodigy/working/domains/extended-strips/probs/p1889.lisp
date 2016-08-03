(setf (current-problem)
  (create-problem
    (name p1889)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmB)
          (dr-to-rm drA rmD)
          (connects drA rmB rmD)
          (connects drA rmD rmB)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (locked drD)
          (dr-closed drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmB)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (holding boxA)
          (holding keyD)
          (inroom keyC rmB)
          (dr-open drA)
          (unlocked drA)
          (inroom robot rmA)
))))