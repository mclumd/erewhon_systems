(setf (current-problem)
  (create-problem
    (name p4)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on-table blockA)
))))