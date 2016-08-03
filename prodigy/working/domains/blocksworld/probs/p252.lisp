(setf (current-problem)
  (create-problem
    (name p252)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))