(setf (current-problem)
  (create-problem
    (name p468)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))