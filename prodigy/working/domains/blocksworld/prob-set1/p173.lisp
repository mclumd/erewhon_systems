(setf (current-problem)
  (create-problem
    (name p173)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on-table blockA)
))))