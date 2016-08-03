(setf (current-problem)
  (create-problem
    (name p457)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on-table blockH)
))))