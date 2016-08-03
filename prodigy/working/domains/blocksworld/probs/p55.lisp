(setf (current-problem)
  (create-problem
    (name p55)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))