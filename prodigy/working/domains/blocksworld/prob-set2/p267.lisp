(setf (current-problem)
  (create-problem
    (name p267)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))