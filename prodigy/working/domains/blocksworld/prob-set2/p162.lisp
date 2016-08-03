(setf (current-problem)
  (create-problem
    (name p162)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))