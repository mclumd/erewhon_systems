(setf (current-problem)
  (create-problem
    (name p1068)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmB)
          (connects drC rmA rmB)
          (connects drC rmB rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmB)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmB)
          (carriable boxC)
          (inroom boxC rmD)
          (carriable boxB)
          (inroom boxB rmA)
          (pushable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (holding boxC)
))))