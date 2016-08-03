(setf (current-problem)
  (create-problem
    (name p1985)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmC)
          (connects drB rmA rmC)
          (connects drB rmC rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmD)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmA)
          (arm-empty)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (holding boxC)
          (inroom boxA rmC)
          (inroom boxB rmC)
          (inroom keyC rmC)
))))