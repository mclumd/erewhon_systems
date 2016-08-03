(setf (current-problem)
  (create-problem
    (name p709)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))