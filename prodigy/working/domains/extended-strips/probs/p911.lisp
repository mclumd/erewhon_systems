(setf (current-problem)
  (create-problem
    (name p911)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmD)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxB)
          (inroom boxB rmA)
          (pushable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmA)
))))