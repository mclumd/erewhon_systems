(setf (current-problem)
  (create-problem
    (name p198)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
))))