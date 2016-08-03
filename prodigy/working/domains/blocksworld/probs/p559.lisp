(setf (current-problem)
  (create-problem
    (name p559)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on-table blockC)
))))