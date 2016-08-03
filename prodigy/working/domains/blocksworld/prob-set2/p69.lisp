(setf (current-problem)
  (create-problem
    (name p69)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))