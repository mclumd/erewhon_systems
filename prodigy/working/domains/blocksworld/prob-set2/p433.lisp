(setf (current-problem)
  (create-problem
    (name p433)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))