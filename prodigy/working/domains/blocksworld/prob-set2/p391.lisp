(setf (current-problem)
  (create-problem
    (name p391)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))