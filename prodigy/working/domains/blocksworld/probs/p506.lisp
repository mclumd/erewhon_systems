(setf (current-problem)
  (create-problem
    (name p506)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))