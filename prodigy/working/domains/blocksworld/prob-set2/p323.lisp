(setf (current-problem)
  (create-problem
    (name p323)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))