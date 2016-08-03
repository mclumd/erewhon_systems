(setf (current-problem)
  (create-problem
    (name p1808)
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
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (locked drD)
          (dr-closed drD)
          (is-key keyD drD)
          (carriable keyD)
          (inroom keyD rmD)
          (inroom robot rmB)
          (carriable boxC)
          (holding boxC)
          (pushable boxA)
          (inroom boxA rmB)
          (carriable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (holding boxB)
          (inroom boxC rmB)
          (inroom boxA rmB)
          (holding keyB)
))))