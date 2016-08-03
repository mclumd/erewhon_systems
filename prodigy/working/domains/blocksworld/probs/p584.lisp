(setf (current-problem)
  (create-problem
    (name p584)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on-table blockA)
))))