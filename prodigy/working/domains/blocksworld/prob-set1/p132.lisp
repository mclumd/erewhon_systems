(setf (current-problem)
  (create-problem
    (name p132)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))