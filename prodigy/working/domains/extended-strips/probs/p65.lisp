(setf (current-problem)
  (create-problem
    (name p65)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmC)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (unlocked drD)
          (dr-closed drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmA)
          (carriable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmC)
          (inroom boxC rmD)
))))