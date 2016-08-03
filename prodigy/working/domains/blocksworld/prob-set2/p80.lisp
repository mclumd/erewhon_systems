(setf (current-problem)
  (create-problem
    (name p80)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on-table blockF)
))))