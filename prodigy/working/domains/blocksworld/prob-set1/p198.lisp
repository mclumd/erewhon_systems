(setf (current-problem)
  (create-problem
    (name p198)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on-table blockF)
))))