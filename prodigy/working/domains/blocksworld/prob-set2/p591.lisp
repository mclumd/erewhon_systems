(setf (current-problem)
  (create-problem
    (name p591)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockG)
          (on-table blockG)
))))