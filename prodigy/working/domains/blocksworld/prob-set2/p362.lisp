(setf (current-problem)
  (create-problem
    (name p362)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))