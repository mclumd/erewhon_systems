(setf (current-problem)
  (create-problem
    (name p193)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))))