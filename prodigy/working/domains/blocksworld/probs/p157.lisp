(setf (current-problem)
  (create-problem
    (name p157)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on-table blockE)
))))