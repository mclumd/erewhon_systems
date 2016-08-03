(setf (current-problem)
  (create-problem
    (name p869)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))))