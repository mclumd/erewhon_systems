(setf (current-problem)
  (create-problem
    (name p361)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on-table blockH)
))))