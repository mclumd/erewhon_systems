(setf (current-problem)
  (create-problem
    (name p390)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))))