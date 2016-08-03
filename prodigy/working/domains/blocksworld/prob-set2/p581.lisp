(setf (current-problem)
  (create-problem
    (name p581)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on-table blockC)
))))