(setf (current-problem)
  (create-problem
    (name p965)
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
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmB)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmA)
          (pushable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxA)
          (inroom boxB rmC)
          (inroom robot rmD)
))))