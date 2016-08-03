(setf (current-problem)
  (create-problem
    (name p579)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))))