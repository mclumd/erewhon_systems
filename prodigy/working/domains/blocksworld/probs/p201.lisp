(setf (current-problem)
  (create-problem
    (name p201)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockB)
          (on blockB blockE)
          (on-table blockE)
))))