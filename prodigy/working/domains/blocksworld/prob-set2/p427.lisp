(setf (current-problem)
  (create-problem
    (name p427)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))