(setf (current-problem)
  (create-problem
    (name p526)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))