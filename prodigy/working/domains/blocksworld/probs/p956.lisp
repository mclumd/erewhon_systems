(setf (current-problem)
  (create-problem
    (name p956)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))