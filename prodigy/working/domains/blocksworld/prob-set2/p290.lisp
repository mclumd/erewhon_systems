(setf (current-problem)
  (create-problem
    (name p290)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
))))