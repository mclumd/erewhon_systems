(setf (current-problem)
  (create-problem
    (name p192)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on-table blockG)
))))