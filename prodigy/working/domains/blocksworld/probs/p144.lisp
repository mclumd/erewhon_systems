(setf (current-problem)
  (create-problem
    (name p144)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))