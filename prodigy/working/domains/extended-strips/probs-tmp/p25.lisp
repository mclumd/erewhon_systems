(setf (current-problem)
  (create-problem
    (name p25)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmB)
          (dr-to-rm drA rmD)
          (connects drA rmB rmD)
          (connects drA rmD rmB)
          (locked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmB)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (inroom boxA rmA)
          (inroom robot rmC)
          (inroom keyC rmA)
))))