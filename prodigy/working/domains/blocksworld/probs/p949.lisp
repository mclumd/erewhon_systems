(setf (current-problem)
  (create-problem
    (name p949)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on-table blockB)
))))