(setf (current-problem)
  (create-problem
    (name p545)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))