(setf (current-problem)
  (create-problem
    (name p515)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on-table blockC)
))))