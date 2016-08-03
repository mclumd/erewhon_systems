(setf (current-problem)
  (create-problem
    (name p454)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
))))