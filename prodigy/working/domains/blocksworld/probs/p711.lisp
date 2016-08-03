(setf (current-problem)
  (create-problem
    (name p711)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on-table blockG)
))))