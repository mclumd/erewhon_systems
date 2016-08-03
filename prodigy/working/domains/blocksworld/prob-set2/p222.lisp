(setf (current-problem)
  (create-problem
    (name p222)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))))