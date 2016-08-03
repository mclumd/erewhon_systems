(setf (current-problem)
  (create-problem
    (name p821)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmC)
          (connects drA rmA rmC)
          (connects drA rmC rmA)
          (unlocked drA)
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
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmC)
          (carriable boxC)
          (inroom boxC rmA)
          (carriable boxD)
          (inroom boxD rmA)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom boxB rmC)
          (inroom boxC rmD)
          (inroom boxD rmD)
))))