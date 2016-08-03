(setf (current-problem)
  (create-problem
    (name p217)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))