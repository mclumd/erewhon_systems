(setf (current-problem)
  (create-problem
    (name p513)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))))