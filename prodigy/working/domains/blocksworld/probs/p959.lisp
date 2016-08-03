(setf (current-problem)
  (create-problem
    (name p959)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on-table blockB)
))))