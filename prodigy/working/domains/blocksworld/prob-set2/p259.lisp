(setf (current-problem)
  (create-problem
    (name p259)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))