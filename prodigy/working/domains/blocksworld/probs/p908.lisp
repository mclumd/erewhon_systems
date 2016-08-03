(setf (current-problem)
  (create-problem
    (name p908)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on-table blockE)
))))