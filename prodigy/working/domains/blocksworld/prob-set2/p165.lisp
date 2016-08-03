(setf (current-problem)
  (create-problem
    (name p165)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on-table blockC)
))))