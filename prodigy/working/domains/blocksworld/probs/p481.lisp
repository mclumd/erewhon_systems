(setf (current-problem)
  (create-problem
    (name p481)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on-table blockH)
))))