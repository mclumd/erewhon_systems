(setf (current-problem)
  (create-problem
    (name p379)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (locked drA)
          (dr-closed drA)
          (is-key keyD drA)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (locked drD)
          (dr-closed drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (holding boxC)
))))