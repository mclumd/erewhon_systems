(setf (current-problem)
  (create-problem
    (name p926)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))