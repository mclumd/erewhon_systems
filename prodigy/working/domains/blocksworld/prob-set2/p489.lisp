(setf (current-problem)
  (create-problem
    (name p489)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockG)
          (on-table blockG)
))))