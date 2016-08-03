(setf (current-problem)
  (create-problem
    (name p614)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))