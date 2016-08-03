(setf (current-problem)
  (create-problem
    (name p784)
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
          (dr-open drA)
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (unlocked drB)
          (dr-closed drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-open drC)
          (is-key keyA drC)
          (carriable keyA)
          (inroom keyA rmC)
          (inroom robot rmA)
          (carriable boxB)
          (holding boxB)
          (pushable boxD)
          (inroom boxD rmD)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmD)
))
    (goal
      (and
          (holding boxD)
          (inroom boxC rmA)
          (inroom boxB rmC)
))))