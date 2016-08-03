(setf (current-problem)
  (create-problem
    (name p1366)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-open drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmA)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmA)
          (carriable boxA)
          (inroom boxA rmA)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxA rmC)
          (inroom keyA rmC)
))))