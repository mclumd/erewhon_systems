(setf (current-problem)
  (create-problem
    (name p113)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))