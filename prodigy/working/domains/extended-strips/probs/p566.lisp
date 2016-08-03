(setf (current-problem)
  (create-problem
    (name p566)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (locked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (locked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmC)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmC)
          (arm-empty)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxB)
          (inroom boxB rmB)
          (pushable boxA)
          (inroom boxA rmD)
          (carriable boxD)
          (inroom boxD rmC)
))
    (goal
      (and
          (holding boxC)
          (inroom boxA rmA)
          (inroom boxD rmD)
          (inroom boxB rmA)
          (inroom robot rmC)
))))