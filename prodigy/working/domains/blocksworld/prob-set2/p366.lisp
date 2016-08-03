(setf (current-problem)
  (create-problem
    (name p366)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))