(setf (current-problem)
  (create-problem
    (name p470)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))