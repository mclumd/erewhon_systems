(setf (current-problem)
  (create-problem
    (name p635)
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
          (unlocked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyD drC)
          (carriable keyD)
          (inroom keyD rmC)
          (dr-to-rm drD rmB)
          (dr-to-rm drD rmD)
          (connects drD rmB rmD)
          (connects drD rmD rmB)
          (locked drD)
          (dr-closed drD)
          (is-key keyC drD)
          (carriable keyC)
          (inroom keyC rmA)
          (inroom robot rmD)
          (carriable boxC)
          (holding boxC)
          (carriable boxA)
          (inroom boxA rmA)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxB rmD)
          (inroom boxD rmC)
          (inroom boxC rmB)
          (inroom boxA rmD)
))))