(setf (current-problem)
  (create-problem
    (name p206)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))