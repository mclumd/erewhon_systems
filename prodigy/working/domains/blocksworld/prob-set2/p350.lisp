(setf (current-problem)
  (create-problem
    (name p350)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))