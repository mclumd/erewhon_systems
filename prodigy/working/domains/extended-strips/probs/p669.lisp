(setf (current-problem)
  (create-problem
    (name p669)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
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
          (inroom keyB rmB)
          (inroom robot rmC)
          (carriable boxA)
          (holding boxA)
))
    (goal
      (and
          (holding boxA)
))))