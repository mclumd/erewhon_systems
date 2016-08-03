(setf (current-problem)
  (create-problem
    (name p499)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))