(setf (current-problem)
  (create-problem
    (name p326)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (inroom keyD rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (unlocked drD)
          (dr-open drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmB)
          (pushable boxB)
          (inroom boxB rmD)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmD)
))))