(setf (current-problem)
  (create-problem
    (name p768)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))