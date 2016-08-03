(setf (current-problem)
  (create-problem
    (name p291)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))))