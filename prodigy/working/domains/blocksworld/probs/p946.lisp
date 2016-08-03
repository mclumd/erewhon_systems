(setf (current-problem)
  (create-problem
    (name p946)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
))))