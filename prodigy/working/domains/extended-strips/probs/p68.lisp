(setf (current-problem)
  (create-problem
    (name p68)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
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
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-open drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmD)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmC)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmC)
))))