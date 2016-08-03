(setf (current-problem)
  (create-problem
    (name p243)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))