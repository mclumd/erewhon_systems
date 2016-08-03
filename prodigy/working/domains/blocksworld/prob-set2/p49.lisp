(setf (current-problem)
  (create-problem
    (name p49)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on-table blockD)
))))