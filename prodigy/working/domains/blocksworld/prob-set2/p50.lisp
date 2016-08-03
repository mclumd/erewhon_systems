(setf (current-problem)
  (create-problem
    (name p50)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on-table blockG)
))))