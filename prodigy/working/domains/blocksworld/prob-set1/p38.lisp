(setf (current-problem)
  (create-problem
    (name p38)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))