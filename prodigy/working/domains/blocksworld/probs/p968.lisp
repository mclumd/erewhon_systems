(setf (current-problem)
  (create-problem
    (name p968)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))