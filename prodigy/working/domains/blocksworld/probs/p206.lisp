(setf (current-problem)
  (create-problem
    (name p206)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))