(setf (current-problem)
  (create-problem
    (name p720)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
))))