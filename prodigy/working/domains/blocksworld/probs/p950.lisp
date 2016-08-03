(setf (current-problem)
  (create-problem
    (name p950)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
))))