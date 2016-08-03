(setf (current-problem)
  (create-problem
    (name p539)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on-table blockG)
))))