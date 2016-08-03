(setf (current-problem)
  (create-problem
    (name p862)
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
          (unlocked drA)
          (dr-closed drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (locked drC)
          (dr-closed drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (carriable boxA)
          (inroom boxA rmC)
          (pushable boxD)
          (inroom boxD rmA)
          (pushable boxC)
          (inroom boxC rmA)
))
    (goal
      (and
          (inroom boxC rmC)
          (inroom boxB rmA)
          (inroom boxD rmC)
))))