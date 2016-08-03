(setf (current-problem)
  (create-problem
    (name p439)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))