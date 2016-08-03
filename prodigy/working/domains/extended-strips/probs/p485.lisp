(setf (current-problem)
  (create-problem
    (name p485)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
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
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmA)
          (dr-to-rm drB rmB)
          (connects drB rmA rmB)
          (connects drB rmB rmA)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (locked drC)
          (dr-closed drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmA)
          (inroom robot rmB)
          (carriable boxB)
          (holding boxB)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmB)
          (carriable boxD)
          (inroom boxD rmD)
))
    (goal
      (and
          (inroom boxD rmC)
))))