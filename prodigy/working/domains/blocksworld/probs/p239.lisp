(setf (current-problem)
  (create-problem
    (name p239)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))