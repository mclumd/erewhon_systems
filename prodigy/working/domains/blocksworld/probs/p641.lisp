(setf (current-problem)
  (create-problem
    (name p641)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))