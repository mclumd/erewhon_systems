(setf (current-problem)
  (create-problem
    (name p441)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on-table blockH)
))))