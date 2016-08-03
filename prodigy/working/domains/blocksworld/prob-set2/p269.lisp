(setf (current-problem)
  (create-problem
    (name p269)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))