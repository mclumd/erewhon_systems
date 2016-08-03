(setf (current-problem)
  (create-problem
    (name p896)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))