(setf (current-problem)
  (create-problem
    (name p162)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))