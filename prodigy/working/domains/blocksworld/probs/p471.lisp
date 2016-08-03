(setf (current-problem)
  (create-problem
    (name p471)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))