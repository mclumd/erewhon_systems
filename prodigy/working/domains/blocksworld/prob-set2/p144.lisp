(setf (current-problem)
  (create-problem
    (name p144)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on-table blockD)
))))