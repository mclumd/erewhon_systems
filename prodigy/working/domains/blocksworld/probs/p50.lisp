(setf (current-problem)
  (create-problem
    (name p50)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))))