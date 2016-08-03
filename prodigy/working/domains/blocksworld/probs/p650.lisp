(setf (current-problem)
  (create-problem
    (name p650)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))