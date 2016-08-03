(setf (current-problem)
  (create-problem
    (name p234)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))