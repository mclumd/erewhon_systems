(setf (current-problem)
  (create-problem
    (name p15)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))