(setf (current-problem)
  (create-problem
    (name p999)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))