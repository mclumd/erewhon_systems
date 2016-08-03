(setf (current-problem)
  (create-problem
    (name p590)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on-table blockF)
))))