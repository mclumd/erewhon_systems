(setf (current-problem)
  (create-problem
    (name p635)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockD)
          (on-table blockD)
))))