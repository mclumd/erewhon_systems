(setf (current-problem)
  (create-problem
    (name p1656)
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
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmD)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (unlocked drD)
          (dr-closed drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmD)
          (carriable boxC)
          (holding boxC)
          (carriable boxA)
          (inroom boxA rmC)
          (carriable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxB rmC)
          (inroom boxC rmD)
))))