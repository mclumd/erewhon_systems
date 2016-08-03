(setf (current-problem)
  (create-problem
    (name p5)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (unlocked drB)
          (dr-open drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (arm-empty)
          (carriable boxB)
          (inroom boxB rmD)
          (carriable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (inroom boxA rmA)
))))