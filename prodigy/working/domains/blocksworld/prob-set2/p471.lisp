(setf (current-problem)
  (create-problem
    (name p471)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))