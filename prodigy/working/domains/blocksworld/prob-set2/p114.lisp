(setf (current-problem)
  (create-problem
    (name p114)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))