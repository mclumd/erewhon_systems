(setf (current-problem)
  (create-problem
    (name p563)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))))