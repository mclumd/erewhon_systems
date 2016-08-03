(setf (current-problem)
  (create-problem
    (name p980)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on-table blockG)
))))