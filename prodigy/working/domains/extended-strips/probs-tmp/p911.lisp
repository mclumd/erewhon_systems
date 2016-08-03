(setf (current-problem)
  (create-problem
    (name p911)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC drD DOOR)
        (keyA keyB keyC keyD KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (unlocked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmB)
          (dr-to-rm drD rmA)
          (dr-to-rm drD rmC)
          (connects drD rmA rmC)
          (connects drD rmC rmA)
          (unlocked drD)
          (dr-open drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxA)
          (inroom boxA rmA)
          (carriable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmC)
          (pushable boxD)
          (inroom boxD rmA)
))
    (goal
      (and
          (inroom boxC rmC)
          (inroom boxA rmC)
          (inroom boxB rmA)
))))