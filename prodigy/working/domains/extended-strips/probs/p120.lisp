(setf (current-problem)
  (create-problem
    (name p120)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmC)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmD)
          (pushable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxA rmA)
          (inroom boxC rmB)
          (inroom keyA rmB)
          (holding keyC)
))))