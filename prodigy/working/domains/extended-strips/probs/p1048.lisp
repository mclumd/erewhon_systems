(setf (current-problem)
  (create-problem
    (name p1048)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmC)
          (dr-to-rm drA rmD)
          (connects drA rmC rmD)
          (connects drA rmD rmC)
          (unlocked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmA)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmD)
          (inroom robot rmB)
          (carriable boxD)
          (holding boxD)
          (carriable boxB)
          (inroom boxB rmA)
          (pushable boxC)
          (inroom boxC rmD)
          (carriable boxA)
          (inroom boxA rmC)
))
    (goal
      (and
          (inroom boxC rmA)
          (inroom boxB rmA)
          (inroom boxD rmA)
          (inroom boxA rmA)
          (holding keyB)
))))