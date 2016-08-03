(setf (current-problem)
  (create-problem
    (name p717)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on blockB blockC)
          (on-table blockC)
))))