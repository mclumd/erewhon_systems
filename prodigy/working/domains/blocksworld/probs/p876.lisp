(setf (current-problem)
  (create-problem
    (name p876)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))