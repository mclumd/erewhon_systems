(setf (current-problem)
  (create-problem
    (name p31)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))