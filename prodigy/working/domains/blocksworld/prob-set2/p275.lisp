(setf (current-problem)
  (create-problem
    (name p275)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on-table blockH)
))))