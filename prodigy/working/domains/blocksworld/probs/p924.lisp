(setf (current-problem)
  (create-problem
    (name p924)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))))