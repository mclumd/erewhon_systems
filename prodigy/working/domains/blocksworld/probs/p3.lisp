(setf (current-problem)
  (create-problem
    (name p3)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on-table blockH)
))))