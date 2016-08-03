(setf (current-problem)
  (create-problem
    (name p715)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmD)
          (dr-to-rm drD rmC)
          (dr-to-rm drD rmD)
          (connects drD rmC rmD)
          (connects drD rmD rmC)
          (unlocked drD)
          (dr-open drD)
          (is-key keyB drD)
          (carriable keyB)
          (inroom keyB rmC)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmB)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (holding boxA)
))))