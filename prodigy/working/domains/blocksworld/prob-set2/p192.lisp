(setf (current-problem)
  (create-problem
    (name p192)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on-table blockD)
))))