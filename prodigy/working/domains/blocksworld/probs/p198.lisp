(setf (current-problem)
  (create-problem
    (name p198)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))