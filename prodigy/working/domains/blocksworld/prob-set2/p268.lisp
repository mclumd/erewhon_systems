(setf (current-problem)
  (create-problem
    (name p268)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))