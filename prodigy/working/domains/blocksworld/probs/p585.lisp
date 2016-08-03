(setf (current-problem)
  (create-problem
    (name p585)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))))