(setf (current-problem)
  (create-problem
    (name p956)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB drC DOOR)
        (keyA keyB keyC KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (unlocked drA)
          (dr-open drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyC drB)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drC rmA)
          (dr-to-rm drC rmC)
          (connects drC rmA rmC)
          (connects drC rmC rmA)
          (unlocked drC)
          (dr-open drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmA)
          (inroom robot rmB)
          (carriable boxD)
          (holding boxD)
          (pushable boxA)
          (inroom boxA rmD)
          (pushable boxC)
          (inroom boxC rmA)
          (pushable boxB)
          (inroom boxB rmB)
))
    (goal
      (and
          (inroom boxB rmA)
          (inroom boxA rmB)
          (inroom boxC rmA)
))))