(setf (current-problem)
  (create-problem
    (name p770)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))