(setf (current-problem)
  (create-problem
    (name p564)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
))))