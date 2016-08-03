(setf (current-problem)
  (create-problem
    (name p153)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))