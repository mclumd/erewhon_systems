(setf (current-problem)
  (create-problem
    (name p597)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
))))