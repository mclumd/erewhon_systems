(setf (current-problem)
  (create-problem
    (name p780)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))