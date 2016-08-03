(setf (current-problem)
  (create-problem
    (name p580)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))