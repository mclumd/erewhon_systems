(setf (current-problem)
  (create-problem
    (name p44)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))