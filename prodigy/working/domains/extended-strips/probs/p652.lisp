(setf (current-problem)
  (create-problem
    (name p652)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmB)
          (dr-to-rm drA rmD)
          (connects drA rmB rmD)
          (connects drA rmD rmB)
          (unlocked drA)
          (dr-open drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
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
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmD)
          (inroom robot rmC)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxC)
          (inroom boxC rmA)
          (carriable boxB)
          (inroom boxB rmA)
))
    (goal
      (and
          (holding boxC)
          (inroom boxB rmB)
          (inroom boxA rmD)
          (inroom robot rmA)
          (dr-open drA)
          (unlocked drA)
))))