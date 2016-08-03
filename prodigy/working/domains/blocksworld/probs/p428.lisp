(setf (current-problem)
  (create-problem
    (name p428)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on-table blockG)
))))