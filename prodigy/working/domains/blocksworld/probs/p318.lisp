(setf (current-problem)
  (create-problem
    (name p318)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on-table blockB)
))))