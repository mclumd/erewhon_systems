(setf (current-problem)
  (create-problem
    (name p178)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
))))