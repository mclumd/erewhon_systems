(setf (current-problem)
  (create-problem
    (name p323)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on-table blockF)
))))