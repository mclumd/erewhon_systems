(setf (current-problem)
  (create-problem
    (name p960)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on-table blockB)
))))