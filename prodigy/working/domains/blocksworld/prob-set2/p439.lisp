(setf (current-problem)
  (create-problem
    (name p439)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on-table blockA)
))))