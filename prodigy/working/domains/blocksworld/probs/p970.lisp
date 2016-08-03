(setf (current-problem)
  (create-problem
    (name p970)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on-table blockB)
))))