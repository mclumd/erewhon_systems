(setf (current-problem)
  (create-problem
    (name p989)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on-table blockC)
))))