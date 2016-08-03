(setf (current-problem)
  (create-problem
    (name p79)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))