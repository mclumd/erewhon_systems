(setf (current-problem)
  (create-problem
    (name p526)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on-table blockD)
))))