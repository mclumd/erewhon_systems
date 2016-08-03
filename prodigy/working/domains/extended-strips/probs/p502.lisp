(setf (current-problem)
  (create-problem
    (name p502)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
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
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (unlocked drC)
          (dr-open drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmA)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (inroom boxA rmD)
          (inroom robot rmB)
))))