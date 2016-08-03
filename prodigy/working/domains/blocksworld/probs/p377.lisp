(setf (current-problem)
  (create-problem
    (name p377)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
))))