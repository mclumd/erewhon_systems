(setf (current-problem)
  (create-problem
    (name p777)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))