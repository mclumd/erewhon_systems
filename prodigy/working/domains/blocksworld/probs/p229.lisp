(setf (current-problem)
  (create-problem
    (name p229)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))))