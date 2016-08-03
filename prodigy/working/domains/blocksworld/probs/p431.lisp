(setf (current-problem)
  (create-problem
    (name p431)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
))))