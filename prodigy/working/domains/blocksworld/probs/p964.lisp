(setf (current-problem)
  (create-problem
    (name p964)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))))