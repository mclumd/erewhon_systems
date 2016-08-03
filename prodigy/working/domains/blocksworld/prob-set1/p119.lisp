(setf (current-problem)
  (create-problem
    (name p119)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))