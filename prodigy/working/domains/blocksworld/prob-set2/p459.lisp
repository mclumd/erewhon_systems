(setf (current-problem)
  (create-problem
    (name p459)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))