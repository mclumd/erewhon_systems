(setf (current-problem)
  (create-problem
    (name p195)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on-table blockA)
))))