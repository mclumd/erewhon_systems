(setf (current-problem)
  (create-problem
    (name p753)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))