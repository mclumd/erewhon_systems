(setf (current-problem)
  (create-problem
    (name p580)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockH)
          (on-table blockH)
))))