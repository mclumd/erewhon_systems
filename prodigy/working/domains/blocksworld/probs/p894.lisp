(setf (current-problem)
  (create-problem
    (name p894)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
))))