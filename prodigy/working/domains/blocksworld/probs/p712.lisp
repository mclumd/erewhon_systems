(setf (current-problem)
  (create-problem
    (name p712)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on-table blockA)
))))