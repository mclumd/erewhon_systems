(setf (current-problem)
  (create-problem
    (name p667)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))