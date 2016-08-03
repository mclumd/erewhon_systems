(setf (current-problem)
  (create-problem
    (name p630)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))