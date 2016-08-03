(setf (current-problem)
  (create-problem
    (name p350)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))