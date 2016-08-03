(setf (current-problem)
  (create-problem
    (name p188)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))))