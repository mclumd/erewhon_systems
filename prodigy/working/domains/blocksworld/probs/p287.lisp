(setf (current-problem)
  (create-problem
    (name p287)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))