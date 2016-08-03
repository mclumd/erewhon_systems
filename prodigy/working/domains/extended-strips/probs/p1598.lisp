(setf (current-problem)
  (create-problem
    (name p1598)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmB)
          (connects drD rmA rmB)
          (connects drD rmB rmA)
          (unlocked drD)
          (dr-open drD)
          (is-key keyA drD)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxD)
          (inroom boxD rmB)
          (pushable boxB)
          (inroom boxB rmD)
          (carriable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxB rmD)
          (inroom boxD rmC)
          (inroom boxA rmC)
          (inroom boxC rmD)
))))