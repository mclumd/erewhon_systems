(setf (current-problem)
  (create-problem
    (name p214)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))