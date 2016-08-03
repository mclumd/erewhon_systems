(setf (current-problem)
  (create-problem
    (name p675)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
))))