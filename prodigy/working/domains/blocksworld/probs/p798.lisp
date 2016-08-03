(setf (current-problem)
  (create-problem
    (name p798)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))))