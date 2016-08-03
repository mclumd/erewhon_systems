(setf (current-problem)
  (create-problem
    (name p786)
    (objects 
        (rmA rmB rmC rmD ROOM)
        (boxA boxB boxC boxD BOX)
        (drA drB DOOR)
        (keyA keyB KEY)
)
    (state
      (and
          (dr-to-rm drA rmA)
          (dr-to-rm drA rmB)
          (connects drA rmA rmB)
          (connects drA rmB rmA)
          (locked drA)
          (dr-closed drA)
          (is-key keyA drA)
          (carriable keyA)
          (inroom keyA rmB)
          (dr-to-rm drB rmB)
          (dr-to-rm drB rmD)
          (connects drB rmB rmD)
          (connects drB rmD rmB)
          (unlocked drB)
          (dr-open drB)
          (is-key keyB drB)
          (carriable keyB)
          (inroom keyB rmB)
          (inroom robot rmB)
          (arm-empty)
          (pushable boxD)
          (inroom boxD rmC)
          (pushable boxC)
          (inroom boxC rmB)
          (pushable boxA)
          (inroom boxA rmB)
          (pushable boxB)
          (inroom boxB rmC)
))
    (goal
      (and
          (inroom boxC rmD)
))))