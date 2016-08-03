(setf (current-problem)
  (create-problem
    (name p156)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))))