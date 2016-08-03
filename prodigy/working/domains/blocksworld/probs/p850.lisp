(setf (current-problem)
  (create-problem
    (name p850)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on-table blockH)
))))