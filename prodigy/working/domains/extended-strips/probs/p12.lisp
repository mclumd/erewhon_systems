(setf (current-problem)
  (create-problem
    (name p12)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyD drB)
          (carriable keyD)
          (inroom keyD rmA)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (locked drD)
          (dr-closed drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxD)
          (inroom boxD rmD)
          (carriable boxA)
          (inroom boxA rmC)
          (carriable boxB)
          (inroom boxB rmA)
          (carriable boxC)
          (inroom boxC rmC)
))
    (goal
      (and
          (holding boxD)
          (inroom boxA rmC)
          (inroom boxC rmD)
          (inroom boxB rmA)
))))