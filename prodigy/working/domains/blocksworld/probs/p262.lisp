(setf (current-problem)
  (create-problem
    (name p262)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))))