(setf (current-problem)
  (create-problem
    (name p881)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on-table blockB)
))))