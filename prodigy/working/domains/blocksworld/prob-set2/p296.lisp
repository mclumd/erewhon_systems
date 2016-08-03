(setf (current-problem)
  (create-problem
    (name p296)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
))))