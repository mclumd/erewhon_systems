(setf (current-problem)
  (create-problem
    (name p1586)
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
          (is-key keyC drA)
          (carriable keyC)
          (inroom keyC rmC)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drC rmC)
          (dr-to-rm drC rmD)
          (connects drC rmC rmD)
          (connects drC rmD rmC)
          (unlocked drC)
          (dr-open drC)
          (is-key keyB drC)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (carriable boxD)
          (holding boxD)
          (carriable boxB)
          (inroom boxB rmA)
          (carriable boxC)
          (inroom boxC rmB)
          (carriable boxA)
          (inroom boxA rmB)
))
    (goal
      (and
          (inroom boxA rmB)
          (inroom boxB rmC)
))))