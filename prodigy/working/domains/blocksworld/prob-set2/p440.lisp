(setf (current-problem)
  (create-problem
    (name p440)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on-table blockB)
))))