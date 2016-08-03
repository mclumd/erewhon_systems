(setf (current-problem)
  (create-problem
    (name p414)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on-table blockF)
))))