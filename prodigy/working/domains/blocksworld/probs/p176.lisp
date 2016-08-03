(setf (current-problem)
  (create-problem
    (name p176)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))