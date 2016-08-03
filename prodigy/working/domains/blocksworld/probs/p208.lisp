(setf (current-problem)
  (create-problem
    (name p208)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
))))