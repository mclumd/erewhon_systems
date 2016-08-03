(setf (current-problem)
  (create-problem
    (name p952)
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
          (locked drA)
          (dr-closed drA)
          (is-key keyB drA)
          (carriable keyB)
          (inroom keyB rmA)
          (dr-to-rm drB rmC)
          (dr-to-rm drB rmD)
          (connects drB rmC rmD)
          (connects drB rmD rmC)
          (locked drB)
          (dr-closed drB)
          (is-key keyA drB)
          (carriable keyA)
          (inroom keyA rmD)
          (dr-to-rm drC rmB)
          (dr-to-rm drC rmD)
          (connects drC rmB rmD)
          (connects drC rmD rmB)
          (unlocked drC)
          (dr-open drC)
          (is-key keyC drC)
          (carriable keyC)
          (inroom keyC rmA)
          (inroom robot rmA)
          (carriable boxC)
          (holding boxC)
          (carriable boxA)
          (inroom boxA rmD)
          (carriable boxB)
          (inroom boxB rmC)
          (carriable boxD)
          (inroom boxD rmB)
))
    (goal
      (and
          (inroom boxC rmD)
          (inroom boxB rmC)
          (inroom boxD rmD)
          (inroom boxA rmB)
))))