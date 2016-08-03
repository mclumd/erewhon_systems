(setf (current-problem)
  (create-problem
    (name p428)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))